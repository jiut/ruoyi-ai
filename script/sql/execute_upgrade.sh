#!/bin/bash

# ================================
# 智图工厂数据库升级自动化脚本
# 版本：1.0.0
# ================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印标题
echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}   智图工厂数据库升级工具${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# 检查参数
if [ $# -lt 3 ]; then
    echo -e "${RED}用法: $0 <数据库主机> <用户名> <数据库名> [端口]${NC}"
    echo "示例: $0 localhost root ruoyi_ai 3306"
    exit 1
fi

DB_HOST=$1
DB_USER=$2
DB_NAME=$3
DB_PORT=${4:-3306}

# 提示输入密码
echo -e "${YELLOW}请输入数据库密码:${NC}"
read -s DB_PASSWORD

# 检查MySQL连接
echo -e "${BLUE}正在检查数据库连接...${NC}"
mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD -e "USE $DB_NAME;" 2>/dev/null
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ 数据库连接失败，请检查连接参数${NC}"
    exit 1
fi
echo -e "${GREEN}✅ 数据库连接成功${NC}"

# 检查必需的基础表
echo -e "${BLUE}正在检查基础表结构...${NC}"
REQUIRED_TABLES=("des_designer" "des_enterprise" "des_school" "sys_menu")
for table in "${REQUIRED_TABLES[@]}"; do
    result=$(mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD -D$DB_NAME -e "SHOW TABLES LIKE '$table';" 2>/dev/null | grep $table)
    if [ -z "$result" ]; then
        echo -e "${RED}❌ 缺少必需表: $table${NC}"
        echo -e "${YELLOW}请确保已正确导入ruoyi.sql基础数据库${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ 发现表: $table${NC}"
done

# 备份确认
echo ""
echo -e "${YELLOW}⚠️  重要提醒：升级前建议备份数据库${NC}"
echo -e "${YELLOW}是否已经备份数据库？(y/N):${NC}"
read -r backup_confirm
if [[ ! $backup_confirm =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}正在创建数据库备份...${NC}"
    BACKUP_FILE="backup_${DB_NAME}_$(date +%Y%m%d_%H%M%S).sql"
    mysqldump -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_FILE
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ 备份完成: $BACKUP_FILE${NC}"
    else
        echo -e "${RED}❌ 备份失败${NC}"
        exit 1
    fi
fi

# 执行升级
echo ""
echo -e "${BLUE}开始执行数据库升级...${NC}"
echo -e "${YELLOW}这可能需要几分钟时间，请不要中断${NC}"

# 检查升级脚本文件
UPGRADE_SCRIPT="zhitu_factory_upgrade.sql"
if [ ! -f "$UPGRADE_SCRIPT" ]; then
    echo -e "${RED}❌ 升级脚本文件不存在: $UPGRADE_SCRIPT${NC}"
    echo -e "${YELLOW}请确保 $UPGRADE_SCRIPT 文件在当前目录中${NC}"
    exit 1
fi

# 执行升级脚本
mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD $DB_NAME < $UPGRADE_SCRIPT
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ 数据库升级执行完成${NC}"
else
    echo -e "${RED}❌ 数据库升级执行失败${NC}"
    exit 1
fi

# 验证升级结果
echo -e "${BLUE}正在验证升级结果...${NC}"

# 检查新表
NEW_TABLES=("des_task" "des_task_application" "des_task_deliverable" "des_task_payment")
for table in "${NEW_TABLES[@]}"; do
    result=$(mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD -D$DB_NAME -e "SHOW TABLES LIKE '$table';" 2>/dev/null | grep $table)
    if [ -z "$result" ]; then
        echo -e "${RED}❌ 新表创建失败: $table${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ 新表创建成功: $table${NC}"
done

# 检查视图
result=$(mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD -D$DB_NAME -e "SHOW FULL TABLES WHERE Table_type = 'VIEW' AND Tables_in_$DB_NAME = 'v_enterprise_task_application';" 2>/dev/null)
if [ -z "$result" ]; then
    echo -e "${YELLOW}⚠️  视图创建可能失败: v_enterprise_task_application${NC}"
else
    echo -e "${GREEN}✅ 视图创建成功: v_enterprise_task_application${NC}"
fi

# 检查权限菜单
menu_count=$(mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD -D$DB_NAME -e "SELECT COUNT(*) FROM sys_menu WHERE menu_name LIKE '%智图工厂%' OR menu_name LIKE '%任务%';" 2>/dev/null | tail -n 1)
if [ "$menu_count" -gt 0 ]; then
    echo -e "${GREEN}✅ 权限菜单创建成功 ($menu_count 项)${NC}"
else
    echo -e "${YELLOW}⚠️  权限菜单创建可能失败${NC}"
fi

# 检查测试数据
task_count=$(mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD -D$DB_NAME -e "SELECT COUNT(*) FROM des_task;" 2>/dev/null | tail -n 1)
if [ "$task_count" -gt 0 ]; then
    echo -e "${GREEN}✅ 测试数据创建成功 ($task_count 个任务)${NC}"
else
    echo -e "${YELLOW}⚠️  测试数据创建可能失败${NC}"
fi

# 升级完成
echo ""
echo -e "${GREEN}🎉 智图工厂数据库升级完成！${NC}"
echo ""
echo -e "${BLUE}升级总结:${NC}"
echo -e "  • 新增表: des_task, des_task_application, des_task_deliverable, des_task_payment"
echo -e "  • 新增视图: v_enterprise_task_application"  
echo -e "  • 新增权限: 智图工厂相关菜单和按钮权限"
echo -e "  • 测试数据: 已创建示例任务数据"
echo ""
echo -e "${YELLOW}下一步操作:${NC}"
echo -e "  1. 配置应用的审核模式 (DUAL/ENTERPRISE)"
echo -e "  2. 为用户角色分配相应权限"  
echo -e "  3. 更新前端路由配置"
echo -e "  4. 测试API接口功能"
echo ""
echo -e "${BLUE}详细说明请参考: 智图工厂数据库升级指南.md${NC}" 
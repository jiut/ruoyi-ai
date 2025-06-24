#!/bin/bash

# 设计师模拟数据更新脚本
# 注意：此脚本会删除现有数据，请谨慎使用

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 脚本配置
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SQL_FILE="$SCRIPT_DIR/update_mock_data.sql"
BACKUP_DIR="$SCRIPT_DIR/backups"

# 创建备份目录
mkdir -p "$BACKUP_DIR"

echo -e "${YELLOW}=== 设计师模拟数据更新脚本 ===${NC}"
echo

# 检查SQL文件是否存在
if [ ! -f "$SQL_FILE" ]; then
    echo -e "${RED}错误: 找不到SQL文件 $SQL_FILE${NC}"
    exit 1
fi

# 获取数据库连接信息
echo "请输入数据库连接信息："
read -p "数据库主机 (默认: localhost): " DB_HOST
DB_HOST=${DB_HOST:-localhost}

read -p "数据库端口 (默认: 3306): " DB_PORT
DB_PORT=${DB_PORT:-3306}

read -p "数据库名称 (默认: ruoyi): " DB_NAME
DB_NAME=${DB_NAME:-ruoyi}

read -p "用户名: " DB_USER

read -s -p "密码: " DB_PASSWORD
echo

# 确认操作
echo
echo -e "${RED}警告: 此操作将删除现有的所有设计师相关数据！${NC}"
echo "影响的表: des_designer, des_education, des_work_experience, des_work, des_award"
echo
read -p "是否继续? (y/N): " confirm

if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "操作已取消"
    exit 0
fi

# 创建备份
echo
echo -e "${YELLOW}正在创建数据库备份...${NC}"
BACKUP_FILE="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).sql"

mysqldump -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" \
    des_designer des_education des_work_experience des_work des_award des_user_binding \
    > "$BACKUP_FILE" 2>/dev/null

if [ $? -eq 0 ]; then
    echo -e "${GREEN}备份已创建: $BACKUP_FILE${NC}"
else
    echo -e "${RED}备份创建失败！操作终止。${NC}"
    exit 1
fi

# 执行SQL脚本
echo
echo -e "${YELLOW}正在执行数据更新...${NC}"
mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$SQL_FILE" 2>/dev/null

if [ $? -eq 0 ]; then
    echo -e "${GREEN}数据更新成功！${NC}"
    
    # 验证数据
    echo
    echo -e "${YELLOW}验证数据...${NC}"
    
    DESIGNER_COUNT=$(mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -se "SELECT COUNT(*) FROM des_designer" 2>/dev/null)
    EDUCATION_COUNT=$(mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -se "SELECT COUNT(*) FROM des_education" 2>/dev/null)
    WORK_EXP_COUNT=$(mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -se "SELECT COUNT(*) FROM des_work_experience" 2>/dev/null)
    WORK_COUNT=$(mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -se "SELECT COUNT(*) FROM des_work" 2>/dev/null)
    AWARD_COUNT=$(mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -se "SELECT COUNT(*) FROM des_award" 2>/dev/null)
    
    echo "数据统计："
    echo "- 设计师: $DESIGNER_COUNT 条"
    echo "- 教育背景: $EDUCATION_COUNT 条"
    echo "- 工作经历: $WORK_EXP_COUNT 条"
    echo "- 作品: $WORK_COUNT 条"
    echo "- 获奖记录: $AWARD_COUNT 条"
    
    echo
    echo -e "${GREEN}所有操作完成！${NC}"
else
    echo -e "${RED}数据更新失败！${NC}"
    echo "您可以使用以下命令恢复数据："
    echo "mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD $DB_NAME < $BACKUP_FILE"
    exit 1
fi

echo
echo "备份文件位置: $BACKUP_FILE"
echo "如需恢复原始数据，请使用："
echo "mysql -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD $DB_NAME < $BACKUP_FILE" 
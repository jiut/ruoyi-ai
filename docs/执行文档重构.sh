#!/bin/bash

echo "================================================"
echo "📚 Ruoyi-AI 文档结构优化脚本"
echo "================================================"
echo

echo "🔍 正在检查当前目录结构..."
if [ ! -d "docs" ]; then
    echo "❌ 错误：请在项目根目录运行此脚本"
    exit 1
fi

cd docs

echo "✅ 开始执行文档重构..."
echo

echo "📁 第一步：创建新目录结构"
mkdir -p "00-重要文档"
mkdir -p "01-API文档/接口规范"
mkdir -p "01-API文档/接口修复"
mkdir -p "01-API文档/测试工具"
mkdir -p "02-前端文档/核心功能"
mkdir -p "02-前端文档/院校模块"
mkdir -p "02-前端文档/Mock数据"
mkdir -p "03-安全权限"
mkdir -p "04-实施报告"
mkdir -p "05-归档文档/测试相关"
mkdir -p "05-归档文档/问题修复"
mkdir -p "05-归档文档/其他"
echo "✅ 目录结构创建完成"

echo
echo "📋 第二步：移动重要文档（A0开头）"
if [ -f "A01-角色权限验证使用标准.md" ]; then
    mv "A01-角色权限验证使用标准.md" "00-重要文档/"
    echo "✅ 移动 A01 文档"
fi

if [ -f "api/A02-设计师模块逻辑删除标准规范.md" ]; then
    mv "api/A02-设计师模块逻辑删除标准规范.md" "00-重要文档/"
    echo "✅ 移动 A02 文档"
fi

if [ -f "api/A03-设计师档案complete接口优化报告.md" ]; then
    mv "api/A03-设计师档案complete接口优化报告.md" "00-重要文档/"
    echo "✅ 移动 A03 文档"
fi

if [ -f "frontend/完整注册流程设计方案.md" ]; then
    mv "frontend/完整注册流程设计方案.md" "00-重要文档/"
    echo "✅ 移动完整注册流程文档"
fi

echo
echo "🔧 第三步：整理API文档"
if [ -f "api/README.md" ]; then
    mv "api/README.md" "01-API文档/"
    echo "✅ 移动 API README"
fi

# 移动技能标签相关文档
for file in api/技能标签*.md; do
    if [ -f "$file" ]; then
        mv "$file" "01-API文档/接口规范/"
        echo "✅ 移动技能标签文档: $(basename "$file")"
    fi
done

# 移动接口修复相关文档
if [ -f "API接口重复问题修复方案.md" ]; then
    mv "API接口重复问题修复方案.md" "01-API文档/接口修复/"
    echo "✅ 移动接口重复问题修复方案"
fi

if [ -f "application-openapi-fix.md" ]; then
    mv "application-openapi-fix.md" "01-API文档/接口修复/"
    echo "✅ 移动 OpenAPI 修复文档"
fi

if [ -f "api/skills-any-openapi-update.md" ]; then
    mv "api/skills-any-openapi-update.md" "01-API文档/接口修复/"
    echo "✅ 移动技能OpenAPI更新文档"
fi

# 移动设计师档案相关文档
if [ -f "api/设计师档案管理接口优化方案.md" ]; then
    mv "api/设计师档案管理接口优化方案.md" "01-API文档/接口规范/"
    echo "✅ 移动设计师档案管理接口文档"
fi

# 移动Apifox相关文档
for file in Apifox*.md; do
    if [ -f "$file" ]; then
        mv "$file" "01-API文档/测试工具/"
        echo "✅ 移动 Apifox 文档: $(basename "$file")"
    fi
done

echo
echo "💻 第四步：整理前端文档"
# 移动角色相关文档
for file in frontend/角色*.md; do
    if [ -f "$file" ]; then
        mv "$file" "02-前端文档/核心功能/"
        echo "✅ 移动角色相关文档: $(basename "$file")"
    fi
done

# 移动状态字段文档
if [ -f "frontend/前端Status字段适配指南.md" ]; then
    mv "frontend/前端Status字段适配指南.md" "02-前端文档/核心功能/"
    echo "✅ 移动前端Status字段文档"
fi

# 移动院校相关文档
for file in frontend/院校*.md; do
    if [ -f "$file" ]; then
        mv "$file" "02-前端文档/院校模块/"
        echo "✅ 移动院校相关文档: $(basename "$file")"
    fi
done

# 移动Mock数据
if [ -f "frontend/mockSchools.ts" ]; then
    mv "frontend/mockSchools.ts" "02-前端文档/Mock数据/"
    echo "✅ 移动 mockSchools.ts"
fi

echo
echo "🔒 第五步：整理安全权限文档"
for file in security/*.md; do
    if [ -f "$file" ]; then
        mv "$file" "03-安全权限/"
        echo "✅ 移动安全权限文档: $(basename "$file")"
    fi
done

echo
echo "📊 第六步：整理实施报告"
if [ -f "api/技能标签重构实施完成报告.md" ]; then
    mv "api/技能标签重构实施完成报告.md" "04-实施报告/"
    echo "✅ 移动技能标签重构实施报告"
fi

if [ -f "实体类API文档修复总结.md" ]; then
    mv "实体类API文档修复总结.md" "04-实施报告/"
    echo "✅ 移动实体类API文档修复总结"
fi

if [ -f "api/院校全量信息API修复总结.md" ]; then
    mv "api/院校全量信息API修复总结.md" "04-实施报告/"
    echo "✅ 移动院校全量信息API修复总结"
fi

echo
echo "📦 第七步：归档其他文档"
# 移动测试相关文档
if [ -f "认证模块测试步骤.md" ]; then
    mv "认证模块测试步骤.md" "05-归档文档/测试相关/"
    echo "✅ 归档认证模块测试文档"
fi

# 移动问题修复文档
if [ -f "application-status-fix.md" ]; then
    mv "application-status-fix.md" "05-归档文档/问题修复/"
    echo "✅ 归档状态修复文档"
fi

if [ -f "API文档修正说明.md" ]; then
    mv "API文档修正说明.md" "05-归档文档/问题修复/"
    echo "✅ 归档API文档修正说明"
fi

# 移动其他文档
if [ -f "api/绑定已有实体使用指南.md" ]; then
    mv "api/绑定已有实体使用指南.md" "05-归档文档/其他/"
    echo "✅ 归档绑定实体使用指南"
fi

echo
echo "📝 第八步：创建新的README文件"
if [ -f "README-新版.md" ]; then
    cp "README-新版.md" "README.md"
    echo "✅ 更新主README文件"
fi

echo
echo "🎉 文档重构完成！"
echo
echo "📊 重构结果："
echo "  🌟 重要文档已移至 '00-重要文档' 文件夹"
echo "  🔧 API文档已整理至 '01-API文档' 文件夹"
echo "  💻 前端文档已整理至 '02-前端文档' 文件夹"
echo "  🔒 安全文档已整理至 '03-安全权限' 文件夹"
echo "  📊 实施报告已整理至 '04-实施报告' 文件夹"
echo "  📦 其他文档已归档至 '05-归档文档' 文件夹"
echo
echo "📋 下一步建议："
echo "  1. 检查新的文档结构"
echo "  2. 更新代码中的文档链接引用"
echo "  3. 通知团队成员新的文档组织方式"
echo "  4. 删除空的原始文件夹"
echo

cd ..
echo "✅ 重构脚本执行完成！" 
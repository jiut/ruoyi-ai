@echo off
chcp 65001 >nul
echo ================================================
echo 📚 Ruoyi-AI 文档结构优化脚本
echo ================================================
echo.

echo 🔍 正在检查当前目录结构...
if not exist "docs" (
    echo ❌ 错误：请在项目根目录运行此脚本
    pause
    exit /b 1
)

cd docs

echo ✅ 开始执行文档重构...
echo.

echo 📁 第一步：创建新目录结构
mkdir "00-重要文档" 2>nul
mkdir "01-API文档" 2>nul
mkdir "01-API文档\接口规范" 2>nul
mkdir "01-API文档\接口修复" 2>nul
mkdir "01-API文档\测试工具" 2>nul
mkdir "02-前端文档" 2>nul
mkdir "02-前端文档\核心功能" 2>nul
mkdir "02-前端文档\院校模块" 2>nul
mkdir "02-前端文档\Mock数据" 2>nul
mkdir "03-安全权限" 2>nul
mkdir "04-实施报告" 2>nul
mkdir "05-归档文档" 2>nul
mkdir "05-归档文档\测试相关" 2>nul
mkdir "05-归档文档\问题修复" 2>nul
mkdir "05-归档文档\其他" 2>nul
echo ✅ 目录结构创建完成

echo.
echo 📋 第二步：移动重要文档（A0开头）
if exist "A01-角色权限验证使用标准.md" (
    move "A01-角色权限验证使用标准.md" "00-重要文档\" 2>nul
    echo ✅ 移动 A01 文档
)

if exist "api\A02-设计师模块逻辑删除标准规范.md" (
    move "api\A02-设计师模块逻辑删除标准规范.md" "00-重要文档\" 2>nul
    echo ✅ 移动 A02 文档
)

if exist "api\A03-设计师档案complete接口优化报告.md" (
    move "api\A03-设计师档案complete接口优化报告.md" "00-重要文档\" 2>nul
    echo ✅ 移动 A03 文档
)

if exist "frontend\完整注册流程设计方案.md" (
    move "frontend\完整注册流程设计方案.md" "00-重要文档\" 2>nul
    echo ✅ 移动完整注册流程文档
)

echo.
echo 🔧 第三步：整理API文档
if exist "api\README.md" (
    move "api\README.md" "01-API文档\" 2>nul
    echo ✅ 移动 API README
)

:: 移动技能标签相关文档
for %%f in ("api\技能标签*.md") do (
    if exist "%%f" (
        move "%%f" "01-API文档\接口规范\" 2>nul
        echo ✅ 移动技能标签文档: %%~nxf
    )
)

:: 移动接口修复相关文档
if exist "API接口重复问题修复方案.md" (
    move "API接口重复问题修复方案.md" "01-API文档\接口修复\" 2>nul
    echo ✅ 移动接口重复问题修复方案
)

if exist "application-openapi-fix.md" (
    move "application-openapi-fix.md" "01-API文档\接口修复\" 2>nul
    echo ✅ 移动 OpenAPI 修复文档
)

if exist "api\skills-any-openapi-update.md" (
    move "api\skills-any-openapi-update.md" "01-API文档\接口修复\" 2>nul
    echo ✅ 移动技能OpenAPI更新文档
)

:: 移动设计师档案相关文档
if exist "api\设计师档案管理接口优化方案.md" (
    move "api\设计师档案管理接口优化方案.md" "01-API文档\接口规范\" 2>nul
    echo ✅ 移动设计师档案管理接口文档
)

:: 移动Apifox相关文档
for %%f in ("Apifox*.md") do (
    if exist "%%f" (
        move "%%f" "01-API文档\测试工具\" 2>nul
        echo ✅ 移动 Apifox 文档: %%~nxf
    )
)

echo.
echo 💻 第四步：整理前端文档
:: 移动角色相关文档
for %%f in ("frontend\角色*.md") do (
    if exist "%%f" (
        move "%%f" "02-前端文档\核心功能\" 2>nul
        echo ✅ 移动角色相关文档: %%~nxf
    )
)

:: 移动状态字段文档
if exist "frontend\前端Status字段适配指南.md" (
    move "frontend\前端Status字段适配指南.md" "02-前端文档\核心功能\" 2>nul
    echo ✅ 移动前端Status字段文档
)

:: 移动院校相关文档
for %%f in ("frontend\院校*.md") do (
    if exist "%%f" (
        move "%%f" "02-前端文档\院校模块\" 2>nul
        echo ✅ 移动院校相关文档: %%~nxf
    )
)

:: 移动Mock数据
if exist "frontend\mockSchools.ts" (
    move "frontend\mockSchools.ts" "02-前端文档\Mock数据\" 2>nul
    echo ✅ 移动 mockSchools.ts
)

echo.
echo 🔒 第五步：整理安全权限文档
for %%f in ("security\*.md") do (
    if exist "%%f" (
        move "%%f" "03-安全权限\" 2>nul
        echo ✅ 移动安全权限文档: %%~nxf
    )
)

echo.
echo 📊 第六步：整理实施报告
if exist "api\技能标签重构实施完成报告.md" (
    move "api\技能标签重构实施完成报告.md" "04-实施报告\" 2>nul
    echo ✅ 移动技能标签重构实施报告
)

if exist "实体类API文档修复总结.md" (
    move "实体类API文档修复总结.md" "04-实施报告\" 2>nul
    echo ✅ 移动实体类API文档修复总结
)

if exist "api\院校全量信息API修复总结.md" (
    move "api\院校全量信息API修复总结.md" "04-实施报告\" 2>nul
    echo ✅ 移动院校全量信息API修复总结
)

echo.
echo 📦 第七步：归档其他文档
:: 移动测试相关文档
if exist "认证模块测试步骤.md" (
    move "认证模块测试步骤.md" "05-归档文档\测试相关\" 2>nul
    echo ✅ 归档认证模块测试文档
)

:: 移动问题修复文档
if exist "application-status-fix.md" (
    move "application-status-fix.md" "05-归档文档\问题修复\" 2>nul
    echo ✅ 归档状态修复文档
)

if exist "API文档修正说明.md" (
    move "API文档修正说明.md" "05-归档文档\问题修复\" 2>nul
    echo ✅ 归档API文档修正说明
)

:: 移动其他文档
if exist "api\绑定已有实体使用指南.md" (
    move "api\绑定已有实体使用指南.md" "05-归档文档\其他\" 2>nul
    echo ✅ 归档绑定实体使用指南
)

echo.
echo 📝 第八步：创建新的README文件
if exist "README-新版.md" (
    copy "README-新版.md" "README.md" >nul
    echo ✅ 更新主README文件
)

echo.
echo 🎉 文档重构完成！
echo.
echo 📊 重构结果：
echo   🌟 重要文档已移至 "00-重要文档" 文件夹
echo   🔧 API文档已整理至 "01-API文档" 文件夹
echo   💻 前端文档已整理至 "02-前端文档" 文件夹
echo   🔒 安全文档已整理至 "03-安全权限" 文件夹
echo   📊 实施报告已整理至 "04-实施报告" 文件夹
echo   📦 其他文档已归档至 "05-归档文档" 文件夹
echo.
echo 📋 下一步建议：
echo   1. 检查新的文档结构
echo   2. 更新代码中的文档链接引用
echo   3. 通知团队成员新的文档组织方式
echo   4. 删除空的原始文件夹
echo.

cd ..
echo ✅ 重构脚本执行完成！
pause 
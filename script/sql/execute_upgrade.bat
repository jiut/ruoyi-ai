@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

REM ================================
REM 智图工厂数据库升级工具 (Windows)
REM 版本：1.0.0  
REM ================================

echo ================================
echo    智图工厂数据库升级工具
echo ================================
echo.

REM 检查参数
if "%~3"=="" (
    echo 用法: %0 ^<数据库主机^> ^<用户名^> ^<数据库名^> [端口]
    echo 示例: %0 localhost root ruoyi_ai 3306
    pause
    exit /b 1
)

set DB_HOST=%1
set DB_USER=%2  
set DB_NAME=%3
if "%~4"=="" (set DB_PORT=3306) else (set DB_PORT=%4)

REM 输入密码
set /p DB_PASSWORD="请输入数据库密码: "

echo.
echo 正在检查数据库连接...

REM 检查MySQL连接
mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% -e "USE %DB_NAME%;" 2>nul
if errorlevel 1 (
    echo ❌ 数据库连接失败，请检查连接参数
    pause
    exit /b 1
)
echo ✅ 数据库连接成功

echo.
echo 正在检查基础表结构...

REM 检查必需的基础表
set TABLES=des_designer des_enterprise des_school sys_menu
for %%t in (%TABLES%) do (
    mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% -D%DB_NAME% -e "SHOW TABLES LIKE '%%t';" 2>nul | findstr %%t >nul
    if errorlevel 1 (
        echo ❌ 缺少必需表: %%t
        echo 请确保已正确导入ruoyi.sql基础数据库
        pause
        exit /b 1
    )
    echo ✅ 发现表: %%t
)

REM 备份确认
echo.
echo ⚠️  重要提醒：升级前建议备份数据库
set /p backup_confirm="是否已经备份数据库？(y/N): "
if /i not "%backup_confirm%"=="y" (
    echo 正在创建数据库备份...
    for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set CDATE=%%c%%a%%b
    for /f "tokens=1-2 delims=: " %%a in ('time /t') do set CTIME=%%a%%b
    set BACKUP_FILE=backup_%DB_NAME%_%CDATE%_%CTIME%.sql
    mysqldump -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% > !BACKUP_FILE!
    if errorlevel 1 (
        echo ❌ 备份失败
        pause
        exit /b 1
    )
    echo ✅ 备份完成: !BACKUP_FILE!
)

REM 检查升级脚本文件
set UPGRADE_SCRIPT=zhitu_factory_upgrade.sql
if not exist "%UPGRADE_SCRIPT%" (
    echo ❌ 升级脚本文件不存在: %UPGRADE_SCRIPT%
    echo 请确保 %UPGRADE_SCRIPT% 文件在当前目录中
    pause
    exit /b 1
)

REM 执行升级
echo.
echo 开始执行数据库升级...
echo 这可能需要几分钟时间，请不要中断

mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% < %UPGRADE_SCRIPT%
if errorlevel 1 (
    echo ❌ 数据库升级执行失败
    pause
    exit /b 1
)
echo ✅ 数据库升级执行完成

REM 验证升级结果
echo.
echo 正在验证升级结果...

REM 检查新表
set NEW_TABLES=des_task des_task_application des_task_deliverable des_task_payment
for %%t in (%NEW_TABLES%) do (
    mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% -D%DB_NAME% -e "SHOW TABLES LIKE '%%t';" 2>nul | findstr %%t >nul
    if errorlevel 1 (
        echo ❌ 新表创建失败: %%t
        pause
        exit /b 1
    )
    echo ✅ 新表创建成功: %%t
)

REM 检查视图
mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% -D%DB_NAME% -e "SHOW FULL TABLES WHERE Table_type = 'VIEW' AND Tables_in_%DB_NAME% = 'v_enterprise_task_application';" 2>nul | findstr "v_enterprise_task_application" >nul
if errorlevel 1 (
    echo ⚠️  视图创建可能失败: v_enterprise_task_application
) else (
    echo ✅ 视图创建成功: v_enterprise_task_application
)

REM 检查权限菜单
for /f %%i in ('mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% -D%DB_NAME% -se "SELECT COUNT(*) FROM sys_menu WHERE menu_name LIKE '%%智图工厂%%' OR menu_name LIKE '%%任务%%';" 2^>nul') do set menu_count=%%i
if !menu_count! gtr 0 (
    echo ✅ 权限菜单创建成功 ^(!menu_count! 项^)
) else (
    echo ⚠️  权限菜单创建可能失败
)

REM 检查测试数据
for /f %%i in ('mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% -D%DB_NAME% -se "SELECT COUNT(*) FROM des_task;" 2^>nul') do set task_count=%%i
if !task_count! gtr 0 (
    echo ✅ 测试数据创建成功 ^(!task_count! 个任务^)
) else (
    echo ⚠️  测试数据创建可能失败
)

REM 升级完成
echo.
echo 🎉 智图工厂数据库升级完成！
echo.
echo 升级总结:
echo   • 新增表: des_task, des_task_application, des_task_deliverable, des_task_payment
echo   • 新增视图: v_enterprise_task_application
echo   • 新增权限: 智图工厂相关菜单和按钮权限
echo   • 测试数据: 已创建示例任务数据
echo.
echo 下一步操作:
echo   1. 配置应用的审核模式 ^(DUAL/ENTERPRISE^)
echo   2. 为用户角色分配相应权限
echo   3. 更新前端路由配置
echo   4. 测试API接口功能
echo.
echo 详细说明请参考: 智图工厂数据库升级指南.md

pause 
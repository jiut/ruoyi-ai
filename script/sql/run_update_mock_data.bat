@echo off
chcp 65001 > nul
setlocal EnableDelayedExpansion

echo.
echo ===== 设计师模拟数据更新脚本 =====
echo.

REM 检查SQL文件是否存在
if not exist "%~dp0update_mock_data.sql" (
    echo 错误: 找不到SQL文件 update_mock_data.sql
    pause
    exit /b 1
)

REM 创建备份目录
if not exist "%~dp0backups" mkdir "%~dp0backups"

echo 请输入数据库连接信息：
set /p DB_HOST="数据库主机 (默认: localhost): "
if "%DB_HOST%"=="" set DB_HOST=localhost

set /p DB_PORT="数据库端口 (默认: 3306): "
if "%DB_PORT%"=="" set DB_PORT=3306

set /p DB_NAME="数据库名称 (默认: ruoyi): "
if "%DB_NAME%"=="" set DB_NAME=ruoyi

set /p DB_USER="用户名: "

REM 隐藏密码输入（Windows 无法完全隐藏，但不回显）
echo 请输入密码（输入时不显示）:
powershell -Command "$password = Read-Host -AsSecureString; $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password); $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)" > temp_password.txt
set /p DB_PASSWORD=<temp_password.txt
del temp_password.txt

echo.
echo 警告: 此操作将删除现有的所有设计师相关数据！
echo 影响的表: des_designer, des_education, des_work_experience, des_work, des_award
echo.
set /p confirm="是否继续? (y/N): "

if /i not "%confirm%"=="y" (
    echo 操作已取消
    pause
    exit /b 0
)

REM 创建备份
echo.
echo 正在创建数据库备份...
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (
    set mydate=%%c%%a%%b
)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (
    set mytime=%%a%%b
)
set mytime=%mytime: =0%
set BACKUP_FILE=%~dp0backups\backup_%mydate%_%mytime%.sql

mysqldump -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% des_designer des_education des_work_experience des_work des_award des_user_binding > "%BACKUP_FILE%" 2>nul

if %errorlevel% equ 0 (
    echo 备份已创建: %BACKUP_FILE%
) else (
    echo 备份创建失败！操作终止。
    pause
    exit /b 1
)

REM 执行SQL脚本
echo.
echo 正在执行数据更新...
mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% < "%~dp0update_mock_data.sql" 2>nul

if %errorlevel% equ 0 (
    echo 数据更新成功！
    
    REM 验证数据
    echo.
    echo 验证数据...
    
    for /f %%i in ('mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% -se "SELECT COUNT(*) FROM des_designer" 2^>nul') do set DESIGNER_COUNT=%%i
    for /f %%i in ('mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% -se "SELECT COUNT(*) FROM des_education" 2^>nul') do set EDUCATION_COUNT=%%i
    for /f %%i in ('mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% -se "SELECT COUNT(*) FROM des_work_experience" 2^>nul') do set WORK_EXP_COUNT=%%i
    for /f %%i in ('mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% -se "SELECT COUNT(*) FROM des_work" 2^>nul') do set WORK_COUNT=%%i
    for /f %%i in ('mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% -se "SELECT COUNT(*) FROM des_award" 2^>nul') do set AWARD_COUNT=%%i
    
    echo 数据统计：
    echo - 设计师: !DESIGNER_COUNT! 条
    echo - 教育背景: !EDUCATION_COUNT! 条
    echo - 工作经历: !WORK_EXP_COUNT! 条
    echo - 作品: !WORK_COUNT! 条
    echo - 获奖记录: !AWARD_COUNT! 条
    
    echo.
    echo 所有操作完成！
) else (
    echo 数据更新失败！
    echo 您可以使用以下命令恢复数据：
    echo mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% ^< "%BACKUP_FILE%"
    pause
    exit /b 1
)

echo.
echo 备份文件位置: %BACKUP_FILE%
echo 如需恢复原始数据，请使用：
echo mysql -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% ^< "%BACKUP_FILE%"
echo.
pause 
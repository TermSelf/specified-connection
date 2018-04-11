@echo off
REM 以系統管理員身分執行
REM https://sites.google.com/site/eneerge/home/BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------


REM Made by TermSelf
REM Version 2.0_2018_April_4_OpenVPN
:-------------------------------------


REM 初始化
:-------------------------------------
:Initialize_For_OpenVPN

set mode=OpenVPN
set vpnip=10.10.0.0
set interface=TAP-Windows Adapter V9
for /f "tokens=1 delims=. " %%a in ('route print if ^| findstr /E /C:"%interface%"') do (set if=%%a)
set mask_1=255.255.255.255
set mask_2=255.255.255.0
set mask_3=255.255.0.0
set mask_4=255.0.0.0

goto Setting
:-------------------------------------


REM 設定檔
:-------------------------------------
:Setting

set destination=Google Play

set domain=play.google.com
set ip_1=64.18.0.0
set ip_2=66.102.0.0
set ip_3=172.217.0.0
set ip_4=216.58.0.0

goto Set_Gateway
:-------------------------------------


REM 連線完成
:-------------------------------------
:Connected
cls
echo Mode：%mode%
echo VPN IP：%vpnip%
echo Interface：%if%
echo Destination：%destination%
echo.
echo 指定連線運作中
echo.
echo 1.重新連線
echo 2.取消指定連線
echo 3.修改VPN IP
echo 4.查詢IPv4路由狀態
echo Q.離開程式
echo.
set all=
set /p all=請輸入指令:
if /i "%all%"=="1" goto Reconnect
if /i "%all%"=="2" goto Route_Delete
if /i "%all%"=="3" goto Set_VPN_IP
if /i "%all%"=="4" goto Check_Route_IPv4
if /i "%all%"=="q" exit
if /i "%all%"=="" goto Connected
:-------------------------------------


REM 指定連線
:-------------------------------------
:Connect
cls

for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %domain%') do (
>nul 2>&1 route delete %%a.%%b.0.0
>nul 2>&1 route add %%a.%%b.0.0 mask %mask_3% %gateway% if %if% metric 1
)

setlocal EnableDelayedExpansion
for /l %%i in (1,1,4) do (
>nul 2>&1 route delete !ip_%%i!
>nul 2>&1 route add !ip_%%i! mask %mask_3% %gateway% if %if% metric 1
)
setlocal DisableDelayedExpansion

goto Connected
:-------------------------------------


REM 取消指定連線
:-------------------------------------
:Route_Delete
cls

for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %domain%') do (
>nul 2>&1 route delete %%a.%%b.0.0
)

setlocal EnableDelayedExpansion
for /l %%i in (1,1,4) do (
>nul 2>&1 route delete !ip_%%i!
)
setlocal DisableDelayedExpansion

goto Connected
:-------------------------------------


REM 重新連線
:-------------------------------------
:Reconnect

for /f "tokens=1 delims=. " %%a in ('route print if ^| findstr /E /C:"%interface%"') do (set if=%%a)

goto Set_Gateway
:-------------------------------------


REM [OpenVPN] 修改VPN IP
:-------------------------------------
:Set_VPN_IP
cls

ipconfig
echo.
echo.
set /p vpnip=請輸入VPN IP：

goto Connected
:-------------------------------------


REM [OpenVPN] 自動設定閘道
:-------------------------------------
:Set_Gateway

for /f "tokens=1-4 delims=." %%a in ("%vpnip%") do (
set gw_ip_1=%%a
set gw_ip_2=%%b
set gw_ip_3=%%c
set /a gw_ip_4=%%d+1
)
set gateway=%gw_ip_1%.%gw_ip_2%.%gw_ip_3%.%gw_ip_4%

goto Connect
:-------------------------------------


REM 查詢IPv4路由狀態
:-------------------------------------
:Check_Route_IPv4
cls

route print -4
pause

goto Connected
:-------------------------------------


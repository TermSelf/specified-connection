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
REM Version 2.0_2018_April_12_VPN
:-------------------------------------


REM 初始化
:-------------------------------------
:Initialize_For_VPN

set mode=VPN
set vpnid=CN
set gateway=192.168.100.1
for /f "tokens=1 delims=. " %%a in ('route print if ^| findstr "%vpnid%"') do (set if=%%a)
set mask_1=255.255.255.255
set mask_2=255.255.255.0
set mask_3=255.255.0.0
set mask_4=255.0.0.0

goto Setting
:-------------------------------------


REM 設定檔
:-------------------------------------
:Setting

set destination=China Channels

REM [iqiyi]

REM account.dns.iqiyi.com
REM X msg.iqiyi.com
REM www.iqiyi.com
REM static.dns.iqiyi.com
REM e5233.a.akamaiedge.net
REM e5248.a.akamaiedge.net
REM X apollo.iqiyi.com
REM qiyioversea.ddwscache.ourdvs.com
REM passport.iqiyi.com

set iqiyi_domain_1=cache.video.dns.iqiyi.com
set iqiyi_domain_2=e5233.a.akamaiedge.net
set iqiyi_domain_3=l.rcd.dns.iqiyi.com
set iqiyi_domain_4=static.dns.iqiyi.com
set iqiyi_domain_5=account.dns.iqiyi.com
set iqiyi_domain_6=msg.iqiyi.com
set iqiyi_domain_7=iplocation.geo.dns.iqiyi.com
set iqiyi_domain_8=passport.iqiyi.com
set iqiyi_domain_9=mixer.video.dns.iqiyi.com

REM [youku]

set youku_domain=aserver-heyi.m.taobao.com.gds.alibabadns.com

set youku_ip_1=198.11.132.53
set youku_ip_2=198.11.190.6
set youku_ip_3=205.204.101.47

REM [bilibili]

REM bangumi.bilibili.com

set bilibili_domain=interface.hdslb.net

set bilibili_ip_1=47.88.107.100
set bilibili_ip_2=47.88.138.238
set bilibili_ip_3=47.90.50.109
set bilibili_ip_4=47.90.207.174
set bilibili_ip_5=47.91.19.168
set bilibili_ip_6=47.91.74.133
set bilibili_ip_7=14.136.134.116
set bilibili_ip_8=14.136.134.117

REM [tencent]

set tencent_domain=cgiaccess.tcdn.qq.com

set tencent_ip_1=203.205.147.229

goto Connect
:-------------------------------------


REM 連線完成
:-------------------------------------
:Connected
cls
echo Mode：%mode%
echo VPN Name：%vpnid%
echo Interface：%if%
echo Destination：%destination%
echo.
echo 指定連線運作中
echo.
echo 1.重新連線
echo 2.取消指定連線
echo 3.查詢IPv4路由狀態
echo 4.iqiyi(Local)
echo 5.iqiyi(China)
echo 6.bilibili(Local)
echo 7.bilibili(China)
echo Q.離開程式
echo.
set all=
set /p all=請輸入指令:
if /i "%all%"=="1" goto Reconnect
if /i "%all%"=="2" goto Route_Delete
if /i "%all%"=="3" goto Check_Route_IPv4
if /i "%all%"=="4" goto iqiyi_local
if /i "%all%"=="5" goto iqiyi_china
if /i "%all%"=="6" goto bilibili_local
if /i "%all%"=="7" goto bilibili_china
if /i "%all%"=="q" exit
if /i "%all%"=="" goto Connected
:-------------------------------------


REM 指定連線
:-------------------------------------
:Connect
cls

setlocal EnableDelayedExpansion
for /l %%i in (1,1,9) do (
for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup !iqiyi_domain_%%i!') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
>nul 2>&1 route add %%a.%%b.%%c.%%d mask %mask_1% %gateway% if %if% metric 1
))
endlocal
setlocal DisableDelayedExpansion
for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %youku_domain%') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
>nul 2>&1 route add %%a.%%b.%%c.%%d mask %mask_1% %gateway% if %if% metric 1
)
for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %bilibili_domain%') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
>nul 2>&1 route add %%a.%%b.%%c.%%d mask %mask_1% %gateway% if %if% metric 1
)
for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %tencent_domain%') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
>nul 2>&1 route add %%a.%%b.%%c.%%d mask %mask_1% %gateway% if %if% metric 1
)

setlocal EnableDelayedExpansion
for /l %%i in (1,1,3) do (
>nul 2>&1 route delete !youku_ip_%%i!
>nul 2>&1 route add !youku_ip_%%i! mask %mask_1% %gateway% if %if% metric 1
)
for /l %%i in (1,1,8) do (
>nul 2>&1 route delete !bilibili_ip_%%i!
>nul 2>&1 route add !youku_ip_%%i! mask %mask_1% %gateway% if %if% metric 1
)
for /l %%i in (1,1,1) do (
>nul 2>&1 route delete !tencent_ip_%%i!
>nul 2>&1 route add !youku_ip_%%i! mask %mask_1% %gateway% if %if% metric 1
)
endlocal
setlocal DisableDelayedExpansion

echo.
goto Connected
:-------------------------------------


REM 取消指定連線
:-------------------------------------
:Route_Delete
cls
setlocal EnableDelayedExpansion
for /l %%i in (1,1,9) do (
for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup !iqiyi_domain_%%i!') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
))
endlocal
setlocal DisableDelayedExpansion
for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %youku_domain%') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
)
for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %bilibili_domain%') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
)
for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %tencent_domain%') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
)

setlocal EnableDelayedExpansion
for /l %%i in (1,1,3) do (
>nul 2>&1 route delete !youku_ip_%%i!
)
for /l %%i in (1,1,8) do (
>nul 2>&1 route delete !bilibili_ip_%%i!
)
for /l %%i in (1,1,1) do (
>nul 2>&1 route delete !tencent_ip_%%i!
)
endlocal
setlocal DisableDelayedExpansion

goto Connected
:-------------------------------------


REM 重新連線
:-------------------------------------
:Reconnect

for /f "tokens=1 delims=. " %%a in ('route print if ^| findstr "%vpnid%"') do (set if=%%a)

goto Connect
:-------------------------------------


:-------------------------------------
:iqiyi_local
cls

for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %iqiyi_domain_1%') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
)

goto Connected
:-------------------------------------


:-------------------------------------
:iqiyi_china
cls

for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %iqiyi_domain_1%') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
>nul 2>&1 route add %%a.%%b.%%c.%%d mask 255.255.255.255 %gateway% if %if% metric 1
)

goto Connected
:-------------------------------------


:-------------------------------------
:bilibili_local
cls

for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %bilibili_domain%') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
)

goto Connected
:-------------------------------------


:-------------------------------------
:bilibili_china
cls

for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup %bilibili_domain%') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
>nul 2>&1 route add %%a.%%b.%%c.%%d mask 255.255.255.255 %gateway% if %if% metric 1
)

goto Connected
:-------------------------------------


REM 查詢IPv4路由狀態
:-------------------------------------
:Check_Route_IPv4
cls

route print -4
pause

goto Connected
:-------------------------------------


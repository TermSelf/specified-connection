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
>nul 2>&1 chcp 950

REM Made by TermSelf
REM Version 2.4_2019_Feb_3_OpenVPN
:-------------------------------------


REM 初始化
:-------------------------------------
:Initialize_For_OpenVPN

set mode=OpenVPN
set interface=TAP-Windows Adapter V9
set mask_32=255.255.255.255
set mask_24=255.255.255.0
set mask_23=255.255.254.0
set mask_22=255.255.252.0
set mask_21=255.255.248.0
set mask_20=255.255.240.0
set mask_19=255.255.224.0
set mask_18=255.255.192.0
set mask_17=255.255.128.0
set mask_16=255.255.0.0
set mask_15=255.254.0.0
set mask_14=255.252.0.0
set mask_13=255.248.0.0
set mask_12=255.240.0.0
set mask_11=255.224.0.0
set mask_10=255.192.0.0
set mask_9=255.128.0.0
set mask_8=255.0.0.0
set random_num=%random%
>nul 2>&1 del _*_temp.txt
>nul 2>&1 del _*_ip_log.txt
echo 初始化中...

goto Setting
:-------------------------------------


REM 設定檔
:-------------------------------------
:Setting

set destination=Netflix

set domain_1=www.netflix.com

set num_ip_24_3=1
set ip_24_3_1=210.158.148.0

set count_ip_22_1=2
set ip_22_1_1=185.2.220.0
set ip_22_1_2=185.9.188.0

set count_ip_21_1=1
set ip_21_1_1=37.77.184.0

set count_ip_20_1=2
set ip_20_1_1=108.175.32.0
set ip_20_1_2=198.45.48.0

set count_ip_19_1=2
set count_ip_19_2=1
set ip_19_1_1=69.53.224.0
set ip_19_1_2=198.38.96.0
set ip_19_2_1=50.112.128.0

set count_ip_18_1=2
set count_ip_18_2=2
set ip_18_1_1=23.246.0.0
set ip_18_1_2=192.173.64.0
set ip_18_2_1=50.112.192.0
set ip_18_2_2=54.244.0.0

set count_ip_17_1=3

set ip_17_1_1=45.57.0.0
set ip_17_1_2=64.120.128.0
set ip_17_1_3=66.197.128.0

set num=ip_17_2
for %%a in (
50.112.0.0
54.148.0.0
54.236.128.0
) do (echo %%a>>_%random_num%_temp.txt)
set "rows="
for /f "delims=" %%a in (_%random_num%_temp.txt) do set/a rows+=1
set count_%num%=%rows%
(for /l %%a in (1,1,%rows%) do set /p %num%_%%a=)<_%random_num%_temp.txt
del _%random_num%_temp.txt

set num=ip_16_2
for %%a in (
35.153.0.0
35.155.0.0
50.16.0.0
54.72.0.0
54.86.0.0
54.87.0.0
54.88.0.0
54.152.0.0
54.190.0.0
54.191.0.0
54.210.0.0
54.213.0.0
) do (echo %%a>>_%random_num%_temp.txt)
set "rows="
for /f "delims=" %%a in (_%random_num%_temp.txt) do set/a rows+=1
set count_%num%=%rows%
(for /l %%a in (1,1,%rows%) do set /p %num%_%%a=)<_%random_num%_temp.txt
del _%random_num%_temp.txt

set num=ip_15_2
for %%a in (
52.0.0.0
52.2.0.0
52.10.0.0
52.16.0.0
52.44.0.0
52.70.0.0
52.72.0.0
52.86.0.0
52.88.0.0
54.68.0.0
54.70.0.0
54.84.0.0
54.148.0.0
54.164.0.0
54.172.0.0
54.174.0.0
54.186.0.0
54.200.0.0
54.208.0.0
) do (echo %%a>>_%random_num%_temp.txt)
set "rows="
for /f "delims=" %%a in (_%random_num%_temp.txt) do set/a rows+=1
set count_%num%=%rows%
(for /l %%a in (1,1,%rows%) do set /p %num%_%%a=)<_%random_num%_temp.txt
del _%random_num%_temp.txt

set num=ip_14_2
for %%a in (
52.4.0.0
52.20.0.0
52.24.0.0
52.32.0.0
52.36.0.0
52.40.0.0
54.80.0.0
) do (echo %%a>>_%random_num%_temp.txt)
set "rows="
for /f "delims=" %%a in (_%random_num%_temp.txt) do set/a rows+=1
set count_%num%=%rows%
(for /l %%a in (1,1,%rows%) do set /p %num%_%%a=)<_%random_num%_temp.txt
del _%random_num%_temp.txt

set count_ip_13_2=2
set ip_13_2_1=35.160.0.0
set ip_13_2_2=52.200.0.0

set count_ip_12_2=3
set ip_12_2_1=34.192.0.0
set ip_12_2_2=34.208.0.0
set ip_12_2_3=34.224.0.0

rem set ip_16_1=34.0.0.0
rem set ip_16_2=35.0.0.0
rem set ip_16_3=52.0.0.0
rem set ip_16_4=54.0.0.0

goto Set_VPN_IP
:-------------------------------------


REM 連線完成
:-------------------------------------
:Connected
cls
echo Mode：%mode%
echo Interface：%interface%
echo VPN IP：%vpnip%
echo Destination：%destination%
echo Status：%status%
echo.
echo 1.重新連線
echo 2.取消指定連線
echo 3.查詢IPv4路由狀態
echo Q.離開程式
echo.
CHOICE /C 123QOP /N /M "請輸入指令:"
if %errorlevel%==1 goto:Reconnect
if %errorlevel%==2 goto:Route_Delete
if %errorlevel%==3 goto:Check_Route_IPv4
if %errorlevel%==4 goto:exit
if %errorlevel%==5 goto:Switch1
if %errorlevel%==6 goto:Switch2
:-------------------------------------


REM 指定連線
:-------------------------------------
:Connect
cls
echo 連線中...
echo.

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_22_1%) do (
>nul 2>&1 route delete !ip_22_1_%%i!
>nul 2>&1 route add !ip_22_1_%%i! mask %mask_22% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_21_1%) do (
>nul 2>&1 route delete !ip_21_1_%%i!
>nul 2>&1 route add !ip_21_1_%%i! mask %mask_21% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_20_1%) do (
>nul 2>&1 route delete !ip_20_1_%%i!
>nul 2>&1 route add !ip_20_1_%%i! mask %mask_20% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_29_1%) do (
>nul 2>&1 route delete !ip_19_1_%%i!
>nul 2>&1 route add !ip_19_1_%%i! mask %mask_19% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_19_2%) do (
>nul 2>&1 route delete !ip_19_2_%%i!
>nul 2>&1 route add !ip_19_2_%%i! mask %mask_19% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_18_1%) do (
>nul 2>&1 route delete !ip_18_1_%%i!
>nul 2>&1 route add !ip_18_1_%%i! mask %mask_18% %gateway% if %if% metric 1
)
endlocal
setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_18_2%) do (
>nul 2>&1 route delete !ip_18_2_%%i!
>nul 2>&1 route add !ip_18_2_%%i! mask %mask_18% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_17_1%) do (
>nul 2>&1 route delete !ip_17_1_%%i!
>nul 2>&1 route add !ip_17_1_%%i! mask %mask_17% %gateway% if %if% metric 1
)
endlocal
setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_17_2%) do (
>nul 2>&1 route delete !ip_17_2_%%i!
>nul 2>&1 route add !ip_17_2_%%i! mask %mask_17% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_16_2%) do (
>nul 2>&1 route delete !ip_16_2_%%i!
>nul 2>&1 route add !ip_16_2_%%i! mask %mask_16% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_15_2%) do (
>nul 2>&1 route delete !ip_15_2_%%i!
>nul 2>&1 route add !ip_15_2_%%i! mask %mask_15% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_14_2%) do (
>nul 2>&1 route delete !ip_14_2_%%i!
>nul 2>&1 route add !ip_14_2_%%i! mask %mask_14% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_13_2%) do (
>nul 2>&1 route delete !ip_13_2_%%i!
>nul 2>&1 route add !ip_13_2_%%i! mask %mask_13% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_12_2%) do (
>nul 2>&1 route delete !ip_12_2_%%i!
>nul 2>&1 route add !ip_12_2_%%i! mask %mask_12% %gateway% if %if% metric 1
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_24_3%) do (
>nul 2>&1 route delete !ip_24_3_%%i!
>nul 2>&1 route add !ip_24_%%i! mask %mask_24% %gateway% if %if% metric 1
)
endlocal

set status=ON

goto Connected
:-------------------------------------


REM 取消指定連線
:-------------------------------------
:Route_Delete
cls
echo 取消連線中...

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_22_1%) do (
>nul 2>&1 route delete !ip_22_1_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_21_1%) do (
>nul 2>&1 route delete !ip_21_1_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_20_1%) do (
>nul 2>&1 route delete !ip_20_1_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_19_1%) do (
>nul 2>&1 route delete !ip_19_1_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_19_2%) do (
>nul 2>&1 route delete !ip_19_2_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_18_1%) do (
>nul 2>&1 route delete !ip_18_1_%%i!
)
endlocal
setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_18_2%) do (
>nul 2>&1 route delete !ip_18_2_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_17_1%) do (
>nul 2>&1 route delete !ip_17_1_%%i!
)
endlocal
setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_17_2%) do (
>nul 2>&1 route delete !ip_17_2_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_16_2%) do (
>nul 2>&1 route delete !ip_16_2_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_15_2%) do (
>nul 2>&1 route delete !ip_15_2_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_14_2%) do (
>nul 2>&1 route delete !ip_14_2_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_13_2%) do (
>nul 2>&1 route delete !ip_13_2_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_12_2%) do (
>nul 2>&1 route delete !ip_12_2_%%i!
)
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_24_3%) do (
>nul 2>&1 route delete !ip_24_3_%%i!
)
endlocal

for /f "tokens=3 skip=%skip% delims=: " %%a in ('netsh interface ipv4 show ipaddresses') do (echo %%a>>_%random_num%_ip_log.txt)
(for /l %%a in (1,1,1) do set /p vpnip_check=)<_%random_num%_ip_log.txt
del _%random_num%_ip_log.txt
if %vpnip_check%==infinite goto:error

set status=OFF

goto Connected
:-------------------------------------


REM 重新連線
:-------------------------------------
:Reconnect

goto Set_VPN_IP
:-------------------------------------


REM [OpenVPN] 自動設定地址
:-------------------------------------
:Set_VPN_IP

for /f "tokens=1 delims=. " %%a in ('route print if ^| findstr /e /c:"%interface%"') do (set if= %%a )
for /f "tokens=5-8 delims= " %%a in ('netsh interface ipv4 show interfaces ^| findstr /c:"%if%"') do (set id=%%a %%b %%c %%d)
for /f "tokens=*" %%i in ("%if%") do (set if=%%~nxi)
for /f "tokens=*" %%i in ("%id%") do (set id=%%~nxi)
for /f "tokens=1 delims=.: " %%a in ('netsh interface ipv4 show ipaddresse ^| findstr /n /e /c:": %id%"') do (set skip_default=%%a)
set /a skip=%skip_default%+3
for /f "tokens=3 skip=%skip% delims=: " %%a in ('netsh interface ipv4 show ipaddresses') do (echo %%a>>_%random_num%_ip_log.txt)
(for /l %%a in (1,1,1) do set /p vpnip_check=)<_%random_num%_ip_log.txt
del _%random_num%_ip_log.txt
if %vpnip_check%==infinite goto:error
for /f "tokens=5 skip=%skip% delims=: " %%a in ('netsh interface ipv4 show ipaddresses') do (echo %%a>>_%random_num%_ip_log.txt)
(for /l %%a in (1,1,1) do set /p vpnip=)<_%random_num%_ip_log.txt
del _%random_num%_ip_log.txt

goto Set_Gateway
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


REM [OpenVPN] 未連線
:-------------------------------------
:error

set status=OFF
set vpnip=Not Detected

goto Connected
:-------------------------------------


REM [OpenVPN] 切換
:-------------------------------------
:Switch1
set interface=TAP-Windows Adapter V9
goto Connected
:Switch2
set interface=TAP-Windows Adapter V9 #2
goto Connected
:-------------------------------------

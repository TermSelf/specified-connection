@echo off
REM �H�t�κ޲z����������
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


REM ��l��
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
echo ��l�Ƥ�...

goto Setting
:-------------------------------------


REM �]�w��
:-------------------------------------
:Setting

set destination=BaiduPan

REM domain/32
set num=domain_32
for %%a in (
pan.baidu.com
wefan.baidu.com
) do (echo %%a>>_%random_num%_temp.txt)
set "rows="
for /f "delims=" %%a in (_%random_num%_temp.txt) do set/a rows+=1
set count_%num%=%rows%
(for /l %%a in (1,1,%rows%) do set /p %num%_%%a=)<_%random_num%_temp.txt
del _%random_num%_temp.txt

REM ip/32
set num=ip_32
for %%a in (
111.206.37.70
) do (echo %%a>>_%random_num%_temp.txt)
set "rows="
for /f "delims=" %%a in (_%random_num%_temp.txt) do set/a rows+=1
set count_%num%=%rows%
(for /l %%a in (1,1,%rows%) do set /p %num%_%%a=)<_%random_num%_temp.txt
del _%random_num%_temp.txt

goto Set_VPN_IP
:-------------------------------------


REM �s�u����
:-------------------------------------
:Connected
cls
echo Mode�G%mode%
echo Interface�G%interface%
echo VPN IP�G%vpnip%
echo Destination�G%destination%
echo Status�G%status%
echo.
echo 1.���s�s�u
echo 2.�������w�s�u
echo 3.�d��IPv4���Ѫ��A
echo Q.���}�{��
echo.
CHOICE /C 123QOP /N /M "�п�J���O:"
if %errorlevel%==1 goto:Reconnect
if %errorlevel%==2 goto:Route_Delete
if %errorlevel%==3 goto:Check_Route_IPv4
if %errorlevel%==4 goto:exit
if %errorlevel%==5 goto:Switch1
if %errorlevel%==6 goto:Switch2
:-------------------------------------


REM ���w�s�u
:-------------------------------------
:Connect
cls
echo �s�u��...
echo.

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_domain_32%) do (
for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup !domain_32_%%i!') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
>nul 2>&1 route add %%a.%%b.%%c.%%d mask %mask_32% %gateway% if %if% metric 1
))
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_32%) do (
>nul 2>&1 route delete !ip_32_%%i!
>nul 2>&1 route add !ip_32_%%i! mask %mask_32% %gateway% if %if% metric 1
)
endlocal

set status=ON

goto Connected
:-------------------------------------


REM �������w�s�u
:-------------------------------------
:Route_Delete
cls
echo �����s�u��...
echo.

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_domain_32%) do (
for /f "skip=4 tokens=2-5 delims=.: " %%a in ('nslookup !domain_32_%%i!') do (
>nul 2>&1 route delete %%a.%%b.%%c.%%d
))
endlocal

setlocal EnableDelayedExpansion
for /l %%i in (1,1,%count_ip_32%) do (
>nul 2>&1 route delete !ip_32_%%i!
)
endlocal

for /f "tokens=3 skip=%skip% delims=: " %%a in ('netsh interface ipv4 show ipaddresses') do (echo %%a>>_%random_num%_ip_log.txt)
(for /l %%a in (1,1,1) do set /p vpnip_check=)<_%random_num%_ip_log.txt
del _%random_num%_ip_log.txt
if %vpnip_check%==infinite goto:error

set status=OFF

goto Connected
:-------------------------------------


REM ���s�s�u
:-------------------------------------
:Reconnect

goto Set_VPN_IP
:-------------------------------------


REM [OpenVPN] �۰ʳ]�w�a�}
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


REM [OpenVPN] �۰ʳ]�w�h�D
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


REM �d��IPv4���Ѫ��A
:-------------------------------------
:Check_Route_IPv4
cls

route print -4
pause

goto Connected
:-------------------------------------


REM [OpenVPN] ���s�u
:-------------------------------------
:error

set status=OFF
set vpnip=Not Detected

goto Connected
:-------------------------------------


REM [OpenVPN] ����
:-------------------------------------
:Switch1
set interface=TAP-Windows Adapter V9
goto Connected
:Switch2
set interface=TAP-Windows Adapter V9 #2
goto Connected
:-------------------------------------

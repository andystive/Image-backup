@echo off
rem 脚本提权到管理员运行（请勿修改）
%1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" ::","","runas",1)(window.close)&&exit

rem 关于脚本：
rem Robocopy镜像备份脚本，脚本可实现如下功能：
rem 同步双方目录，完成后制作Log到相应的目录，最后发送邮件到指定邮箱。


rem 以下*号内信息为自定义参数，可根据时间情况进行修改
::********************************************************

rem 设备颜色及窗口大小
::-----------------------------------------------------------------------------------------
::color（颜色）参数，第一个数值为背景色，第二个数值为字体颜色，如:02为黑底绿字
::数值对应关系如下：
::0＝黑、1＝蓝、2＝绿、3＝浅绿、4＝红、5＝紫、6＝黄、7=白、8=灰、9=淡蓝、
::A＝淡绿、B=淡浅绿、C=淡红、D=淡紫、E=淡黄、F=亮白
::-----------------------------------------------------------------------------------------
::mode（窗体尺寸）参数，第一个数值为窗口高度，第二个数值为窗口宽度
::-----------------------------------------------------------------------------------------
@color 02
mode 80,25

rem 设置脚本标题
title Robocopy镜像备份脚本

rem 设置备份文件夹的路径
::源路径
set src=D:\lcgx
::目标路径
set dst=D:\lcgx_Backup\lcgx

::********************************************************


rem 以下#号以内信息请勿更改
::########################################################

rem 设置变量
::获取当前路径
set loc=%~dp0
::日志目录
set log=%AppData%\Scorpio\log
rem for /f "tokens=1,2 delims=^\" %%a in ("%dst%") do (set "log=%%a\%%b\Inspur\log")
::邮件目录
rem for /f "tokens=1,2 delims=^\" %%a in ("%dst%") do (set "mail=%%a\%%b\Inspur\mail")
set mail=%AppData%\Scorpio\mail
rem 获取当前时间
for /f "tokens=2 delims==" %%a in ('wmic path win32_operatingsystem get LocalDateTime /value') do (set t=%%a)
::当前时间，显示到分钟，需要时启用
rem set Today=%t:~0,4%%t:~4,2%%t:~6,2%%t:~8,2%%t:~10,2%
::当前时间，显示到日期，需要时启用
set Today=%t:~0,4%%t:~4,2%%t:~6,2%

rem 执行数据备份
if not exist %dst% (
    mkdir %log%
    robocopy %src% %dst% /mir /copyall /dcopy:DAT /mt:32 /z /xa:sht /a-:h /np /ts /log:%log%\Backup_%Today%.log /tee
) else (
	robocopy %src% %dst% /mir /copyall /dcopy:DAT /mt:32 /z /maxage:1 /np /ts /log:%log%\Backup_%Today%.log /tee
)

rem 设置邮件发送信息
if not exist %mail% (
    mkdir %mail%
    powershell -c "(gc '%log%\Backup_%Today%.log')[1..8]" >%mail%\MailMessage.txt
    @echo ------------------------------------------------------------------------------- >>%mail%\MailMessage.txt
    powershell -c "(gc '%log%\Backup_%Today%.log')[-12..-1]" >>%mail%\MailMessage.txt
    @echo ------------------------------------------------------------------------------- >>%mail%\MailMessage.txt
) else (
    powershell -c "(gc '%log%\Backup_%Today%.log')[1..8]" >%mail%\MailMessage.txt
    @echo ------------------------------------------------------------------------------- >>%mail%\MailMessage.txt
     powershell -c "(gc '%log%\Backup_%Today%.log')[-12..-1]" >>%mail%\MailMessage.txt
    @echo ------------------------------------------------------------------------------- >>%mail%\MailMessage.txt
)

rem 发送邮件
@ping smtp.yeah.net >nul
start %loc%sendMail.vbs /mailsite:%mail% /logsite:%log%
@ping www.neverstop.club >nul
exit

::########################################################
@echo off
rem �ű���Ȩ������Ա���У������޸ģ�
%1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" ::","","runas",1)(window.close)&&exit

rem ���ڽű���
rem Robocopy���񱸷ݽű����ű���ʵ�����¹��ܣ�
rem ͬ��˫��Ŀ¼����ɺ�����Log����Ӧ��Ŀ¼��������ʼ���ָ�����䡣


rem ����*������ϢΪ�Զ���������ɸ���ʱ����������޸�
::********************************************************

rem �豸��ɫ�����ڴ�С
::-----------------------------------------------------------------------------------------
::color����ɫ����������һ����ֵΪ����ɫ���ڶ�����ֵΪ������ɫ����:02Ϊ�ڵ�����
::��ֵ��Ӧ��ϵ���£�
::0���ڡ�1������2���̡�3��ǳ�̡�4���졢5���ϡ�6���ơ�7=�ס�8=�ҡ�9=������
::A�����̡�B=��ǳ�̡�C=���졢D=���ϡ�E=���ơ�F=����
::-----------------------------------------------------------------------------------------
::mode������ߴ磩��������һ����ֵΪ���ڸ߶ȣ��ڶ�����ֵΪ���ڿ��
::-----------------------------------------------------------------------------------------
@color 02
mode 80,25

rem ���ýű�����
title Robocopy���񱸷ݽű�

rem ���ñ����ļ��е�·��
::Դ·��
set src=D:\lcgx
::Ŀ��·��
set dst=D:\lcgx_Backup\lcgx

::********************************************************


rem ����#��������Ϣ�������
::########################################################

rem ���ñ���
::��ȡ��ǰ·��
set loc=%~dp0
::��־Ŀ¼
set log=%AppData%\Scorpio\log
rem for /f "tokens=1,2 delims=^\" %%a in ("%dst%") do (set "log=%%a\%%b\Inspur\log")
::�ʼ�Ŀ¼
rem for /f "tokens=1,2 delims=^\" %%a in ("%dst%") do (set "mail=%%a\%%b\Inspur\mail")
set mail=%AppData%\Scorpio\mail
rem ��ȡ��ǰʱ��
for /f "tokens=2 delims==" %%a in ('wmic path win32_operatingsystem get LocalDateTime /value') do (set t=%%a)
::��ǰʱ�䣬��ʾ�����ӣ���Ҫʱ����
rem set Today=%t:~0,4%%t:~4,2%%t:~6,2%%t:~8,2%%t:~10,2%
::��ǰʱ�䣬��ʾ�����ڣ���Ҫʱ����
set Today=%t:~0,4%%t:~4,2%%t:~6,2%

rem ִ�����ݱ���
if not exist %dst% (
    mkdir %log%
    robocopy %src% %dst% /mir /copyall /dcopy:DAT /mt:32 /z /xa:sht /a-:h /np /ts /log:%log%\Backup_%Today%.log /tee
) else (
	robocopy %src% %dst% /mir /copyall /dcopy:DAT /mt:32 /z /maxage:1 /np /ts /log:%log%\Backup_%Today%.log /tee
)

rem �����ʼ�������Ϣ
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

rem �����ʼ�
@ping smtp.yeah.net >nul
start %loc%sendMail.vbs /mailsite:%mail% /logsite:%log%
@ping www.neverstop.club >nul
exit

::########################################################
@echo off
rem ���ڽű���
rem �����ʼ���ű����ű���ʵ�����¹��ܣ�
rem ���������ű���ɹ��ܲ���

rem ���ñ����ӳ���չ����ȡ��ǰ·��
setlocal enabledelayedexpansion
set loc=%~dp0

rem �豸��ɫ�����ڴ�С
@color 02
mode 80,35

:menu
cls
echo.
echo.          #######################################################
echo.          ##                                                   ##
echo.          ##    �ű����ܣ�                                     ##
echo.          ##    1. �ƶ��ƻ�����ָ��ʱ���Ƶ��ִ�б��ݽű���  ##
echo.          ##    2. ִ��Դ�ļ��е�Ŀ���ļ��еľ��񱸷ݣ�        ##
echo.          ##    3. ���ͱ��ݽ������־��ָ������.               ##
echo.          ##                                                   ##
echo.          ##    �ű�Ĭ�ϲ�����                                 ##
echo.          ##    1. �ƻ�����ʱ�䣺23:00��Ƶ�ʣ�ÿ��           ##
echo.          ##    2. ԴĿ¼��D:\lcgx                             ##
echo.          ##    3. Ŀ��Ŀ¼��D:\lcgx_Backup\lcgx               ##
echo.          ##                                                   ##
echo.          #######################################################
echo.
echo                            ѡ����Ҫִ�е�ѡ��
echo           -------------------------------------------------------
echo.
echo                        1. �ƶ��ƻ�����
echo.
echo                        2. �������б��ݽű��������ݱ���
echo.
echo                        3. �޸ļƻ�����ű�����
echo.
echo                        4. �޸����ݱ��ݽű�����
echo.
echo.                       5. �޸��ʼ����ͽű�����
echo.
echo.                       6. ���ڽű�
echo.
echo           -------------------------------------------------------
echo.
set /p task="��������Ҫִ�е�ѡ���0�˳�����:"
if %task%==1 goto :Schtasks
if %task%==2 goto :Robocopy
if %task%==3 goto :Schtasks_edit
if %task%==4 goto :Robocopy_edit
if %task%==5 goto :sendMail_edit
if %task%==6 goto :README
if %task%==0 goto :quit

:Schtasks
start %loc%Schtasks.bat
goto :menu

:Robocopy
start %loc%Robocopy.bat
goto :menu

:Schtasks_edit
call notepad %loc%Schtasks.bat
goto :menu

:Robocopy_edit
call notepad %loc%Robocopy.bat
goto :menu

:sendMail_edit
call notepad %loc%sendMail.vbs
goto :menu

:README
call %loc%README.txt
goto :menu

:quit
exit

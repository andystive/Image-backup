@echo off
rem �ű���Ȩ������Ա���У������޸ģ�
%1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" ::","","runas",1)(window.close)&&exit

rem ���ñ����ӳ���չ�������޸ģ�
setlocal enabledelayedexpansion
rem ��ȡ��ǰ·��
set loc=%~dp0

rem ���ڽű���
rem Schtasks�ƻ��������ýű����ű���ʵ�����¹��ܣ�
rem ��ӡ�ɾ������ѯsystemȨ�����õļƻ�����
rem ��������ƻ���ÿ�ն�������Robocopy.bat


rem ����*������ϢΪ�Զ���������ɸ���ʱ����������޸�
::********************************************************

rem �豸��ɫ�����ڴ�С���޸�mode�������ܻ�����ı���ʾ��������
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
title Robocopy�ƻ�����

rem �ƻ�������ʾ����
set name=Robocopy

rem �ƻ�����ִ�����ͣ���Чֵ���£�
::DAILY��ÿ�죩��WEEKLY��ÿ�ܣ���MONTHLY��ÿ�£���ONCE�����Σ�
set type=DAILY

rem �ƻ�����ִ��ʱ��
::�� HH:MM:SS 24 Сʱ��ʽָ��ʱ��
set time=23:00

::********************************************************


rem ����#��������Ϣ�������
::########################################################

cls
echo.
echo                                ѡ����Ҫִ�е�ѡ��
echo.
echo                      -------------------------------------
echo.
echo                             1. ������ݱ��ݼƻ�����
echo.
echo                             2. ɾ�����ݱ��ؼƻ�����
echo.
echo                             3. ��ѯ���ݱ��ݼƻ�����
echo.
echo                      -------------------------------------

:select
echo.
set /p task="ѡ��ִ�е�ѡ���0�˳�����:"
if %task%==1 goto :Create_task
if %task%==2 goto :Delete_task
if %task%==3 goto :Query_task
if %task%==0 goto :quit

:Create_task
SCHTASKS /Create /TN %name% /SC %type% /ST %time% /RU "System" /TR %loc%Robocopy.bat >nul
echo �ƻ������ѳɹ�����
goto :Query_task

:Query_task
SCHTASKS /Query /TN Robocopy
goto :select

:Delete_task
SCHTASKS /Delete /TN Robocopy /F >nul
echo �ƻ������ѳɹ�ɾ��
goto :select

:quit
exit

::########################################################
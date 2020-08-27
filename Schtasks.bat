@echo off
rem 脚本提权到管理员运行（请勿修改）
%1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" ::","","runas",1)(window.close)&&exit

rem 设置变量延迟扩展（请勿修改）
setlocal enabledelayedexpansion
rem 获取当前路径
set loc=%~dp0

rem 关于脚本：
rem Schtasks计划任务设置脚本，脚本可实现如下功能：
rem 添加、删除、查询system权限设置的计划任务。
rem 创建任务计划，每日定点运行Robocopy.bat


rem 以下*号内信息为自定义参数，可根据时间情况进行修改
::********************************************************

rem 设备颜色及窗口大小（修改mode参数可能会造成文本显示不完整）
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
title Robocopy计划任务

rem 计划任务显示名称
set name=Robocopy

rem 计划任务执行类型，有效值如下：
::DAILY（每天）、WEEKLY（每周）、MONTHLY（每月）、ONCE（单次）
set type=DAILY

rem 计划任务执行时间
::以 HH:MM:SS 24 小时格式指定时间
set time=23:00

::********************************************************


rem 以下#号以内信息请勿更改
::########################################################

cls
echo.
echo                                选择需要执行的选项
echo.
echo                      -------------------------------------
echo.
echo                             1. 添加数据备份计划任务
echo.
echo                             2. 删除数据本地计划任务
echo.
echo                             3. 查询数据备份计划任务
echo.
echo                      -------------------------------------

:select
echo.
set /p task="选择执行的选项或按0退出程序:"
if %task%==1 goto :Create_task
if %task%==2 goto :Delete_task
if %task%==3 goto :Query_task
if %task%==0 goto :quit

:Create_task
SCHTASKS /Create /TN %name% /SC %type% /ST %time% /RU "System" /TR %loc%Robocopy.bat >nul
echo 计划任务已成功创建
goto :Query_task

:Query_task
SCHTASKS /Query /TN Robocopy
goto :select

:Delete_task
SCHTASKS /Delete /TN Robocopy /F >nul
echo 计划任务已成功删除
goto :select

:quit
exit

::########################################################
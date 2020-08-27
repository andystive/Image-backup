@echo off
rem 关于脚本：
rem 程序初始化脚本，脚本可实现如下功能：
rem 调用其他脚本完成功能部署

rem 设置变量延迟扩展，获取当前路径
setlocal enabledelayedexpansion
set loc=%~dp0

rem 设备颜色及窗口大小
@color 02
mode 80,35

:menu
cls
echo.
echo.          #######################################################
echo.          ##                                                   ##
echo.          ##    脚本功能：                                     ##
echo.          ##    1. 制定计划任务，指定时间和频率执行备份脚本；  ##
echo.          ##    2. 执行源文件夹到目标文件夹的镜像备份；        ##
echo.          ##    3. 发送备份结果及日志到指定邮箱.               ##
echo.          ##                                                   ##
echo.          ##    脚本默认参数：                                 ##
echo.          ##    1. 计划任务，时间：23:00，频率：每天           ##
echo.          ##    2. 源目录：D:\lcgx                             ##
echo.          ##    3. 目标目录：D:\lcgx_Backup\lcgx               ##
echo.          ##                                                   ##
echo.          #######################################################
echo.
echo                            选择需要执行的选项
echo           -------------------------------------------------------
echo.
echo                        1. 制定计划任务
echo.
echo                        2. 立即运行备份脚本进行数据备份
echo.
echo                        3. 修改计划任务脚本参数
echo.
echo                        4. 修改数据备份脚本参数
echo.
echo.                       5. 修改邮件发送脚本参数
echo.
echo.                       6. 关于脚本
echo.
echo           -------------------------------------------------------
echo.
set /p task="请输入需要执行的选项或按0退出程序:"
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

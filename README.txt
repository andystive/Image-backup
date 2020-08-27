本程序实现功能：
1. 维护计划任务，指定脚本运行时间和频率；
2. 实现指定文件数据镜像备份到指定文件夹；
3. 发送备份结果及日志到指定邮箱。

脚本解压位置：
%AppData%\Scorpio\script

备份日志位置:
%AppData%\Scorpio\log

初始化脚本
initialize.bat

计划任务脚本：
Schtasks.bat

镜像备份脚本：
Robocopy.bat

邮件发送脚本：
sendMail.vbs

快捷方式创建脚本：
shortcut.vbs
Dim Scorpio
set Scorpio=CreateObject("wscript.shell") 
result =msgbox("       应用程序安装成功!  是否立即启动?","4","镜像备份")
if result =vbYes then
Scorpio.run("cmd /c initialize.bat")
else
WScript.quit
end if
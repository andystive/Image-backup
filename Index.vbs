Dim Scorpio
set Scorpio=CreateObject("wscript.shell") 
result =msgbox("       Ӧ�ó���װ�ɹ�!  �Ƿ���������?","4","���񱸷�")
if result =vbYes then
Scorpio.run("cmd /c initialize.bat")
else
WScript.quit
end if
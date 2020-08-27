'关于脚本：
'邮件发送脚本，脚本可实现如下功能：
'自动发送备份结果及备份日志到指定邮箱；


'设置收件地址及邮件主题
'address参数为收件地址，可根据需要进行增删，邮箱地址之间为英文版逗号
address ="mail@163.com"
'strSub参数为邮件发送主题，可根据需要进行修改
strSub ="系统自动发送 请勿回复"


'以下#号以内信息请勿更改
'###################################################################

'获取Robocopy.bat脚本传递的%mail%和%log%变量值
set site =wscript.arguments.named

'获取当前时间
ystr =year(Now)
mstr =Month(Now)
dstr =day(Now)
if len(mstr)<2 then mstr ="0"&mstr
if len(dstr)<2 then dstr ="0"&dstr
Today =ystr&mstr&dstr

'邮件发送
Const ForReading =1 '只读模式
Set objFSO =CreateObject("Scripting.FileSystemObject")
Set objTextFile =objFSO.OpenTextFile(""&site.item("mailsite")&"\MailMessage.txt", ForReading) '获取MailMessage.txt内容，即邮件内容
strText =objTextFile.ReadAll
objTextFile.Close

NameSpace ="http://schemas.microsoft.com/cdo/configuration/"
 Set Email =CreateObject("CDO.Message")
Email.From ="system_auto@yeah.net" '发件邮件地址
 Email.To =address '收件邮件地址
Email.Subject =strSub '邮件主题
Email.Textbody =strText '邮件内容
Email.AddAttachment ""&site.item("logsite")&"\Backup_"&Today&".log" '邮件附件
With Email.Configuration.Fields
.Item(NameSpace&"sendusing") =2'CDO发送端口号
.Item(NameSpace&"smtpserver") ="smtp.yeah.net"'SMTP服务器
.Item(NameSpace&"smtpserverport") =25'SMTP服务器端口号
.Item(NameSpace&"smtpusessl") =true'SMTP服务器是否使用了SSL
.Item(NameSpace&"smtpauthenticate") =1'认证方式是BASIC
.Item(NameSpace&"sendusername") ="mail@yeah.net"'发件人邮箱账号
.Item(NameSpace&"sendpassword") ="password"'发件人邮箱密码
.Update
End With
Email.Send '发送邮件
Set Email =Nothing '关闭组件
WScript.quit

'###################################################################
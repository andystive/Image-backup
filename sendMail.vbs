'���ڽű���
'�ʼ����ͽű����ű���ʵ�����¹��ܣ�
'�Զ����ͱ��ݽ����������־��ָ�����䣻


'�����ռ���ַ���ʼ�����
'address����Ϊ�ռ���ַ���ɸ�����Ҫ������ɾ�������ַ֮��ΪӢ�İ涺��
address ="mail@163.com"
'strSub����Ϊ�ʼ��������⣬�ɸ�����Ҫ�����޸�
strSub ="ϵͳ�Զ����� ����ظ�"


'����#��������Ϣ�������
'###################################################################

'��ȡRobocopy.bat�ű����ݵ�%mail%��%log%����ֵ
set site =wscript.arguments.named

'��ȡ��ǰʱ��
ystr =year(Now)
mstr =Month(Now)
dstr =day(Now)
if len(mstr)<2 then mstr ="0"&mstr
if len(dstr)<2 then dstr ="0"&dstr
Today =ystr&mstr&dstr

'�ʼ�����
Const ForReading =1 'ֻ��ģʽ
Set objFSO =CreateObject("Scripting.FileSystemObject")
Set objTextFile =objFSO.OpenTextFile(""&site.item("mailsite")&"\MailMessage.txt", ForReading) '��ȡMailMessage.txt���ݣ����ʼ�����
strText =objTextFile.ReadAll
objTextFile.Close

NameSpace ="http://schemas.microsoft.com/cdo/configuration/"
 Set Email =CreateObject("CDO.Message")
Email.From ="system_auto@yeah.net" '�����ʼ���ַ
 Email.To =address '�ռ��ʼ���ַ
Email.Subject =strSub '�ʼ�����
Email.Textbody =strText '�ʼ�����
Email.AddAttachment ""&site.item("logsite")&"\Backup_"&Today&".log" '�ʼ�����
With Email.Configuration.Fields
.Item(NameSpace&"sendusing") =2'CDO���Ͷ˿ں�
.Item(NameSpace&"smtpserver") ="smtp.yeah.net"'SMTP������
.Item(NameSpace&"smtpserverport") =25'SMTP�������˿ں�
.Item(NameSpace&"smtpusessl") =true'SMTP�������Ƿ�ʹ����SSL
.Item(NameSpace&"smtpauthenticate") =1'��֤��ʽ��BASIC
.Item(NameSpace&"sendusername") ="mail@yeah.net"'�����������˺�
.Item(NameSpace&"sendpassword") ="password"'��������������
.Update
End With
Email.Send '�����ʼ�
Set Email =Nothing '�ر����
WScript.quit

'###################################################################
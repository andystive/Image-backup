Set Lnk_Args =CreateObject("WScript.Shell")'��������
Set MyLink =Lnk_Args.CreateShortcut(""&Lnk_Args.SpecialFolders("desktop")&"\���񱸷�.lnk") '������ݷ�ʽ
MyLink.TargetPath ="%AppData%\Scorpio\script\initialize.bat" 'Ŀ��·��
MyLink.WindowStyle =1 '���ڷ��1=���棬3=��󻯣�7=��С����
MyLink.WorkingDirectory ="%AppData%\Scorpio\script" '��ʼλ��
MyLink.IconLocation="%SystemRoot%\system32\SHELL32.dll, 80" 'ͼ��
MyLink.Description ="��ʼ�����񱸷�" '��ע
MyLink.Save

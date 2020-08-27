Set Lnk_Args =CreateObject("WScript.Shell")'创建对象
Set MyLink =Lnk_Args.CreateShortcut(""&Lnk_Args.SpecialFolders("desktop")&"\镜像备份.lnk") '创建快捷方式
MyLink.TargetPath ="%AppData%\Scorpio\script\initialize.bat" '目标路径
MyLink.WindowStyle =1 '窗口风格（1=常规，3=最大化，7=最小化）
MyLink.WorkingDirectory ="%AppData%\Scorpio\script" '起始位置
MyLink.IconLocation="%SystemRoot%\system32\SHELL32.dll, 80" '图标
MyLink.Description ="初始化镜像备份" '备注
MyLink.Save

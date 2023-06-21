@goto :start
文件名：ActiveWin10.bat

#Windows 10 LTSC 2021 and 2019
# Operating system edition 	KMS Client Product Key
# Windows 10 Enterprise LTSC 2021
# Windows 10 Enterprise LTSC 2019 	M7XTQ-FN8P6-TTKYV-9D4CC-J462D

# 右键开始菜单，点击 [命令提示符 (管理员)] 或 [Windows PowerShell (管理员)]
执行下面的命令：
.\ActiveWin10.bat

:start


slmgr /upk
slmgr /skms 10.153.70.238  
slmgr /ipk M7XTQ-FN8P6-TTKYV-9D4CC-J462D
slmgr /ato

slmgr -dlv

rem slmgr -xpr

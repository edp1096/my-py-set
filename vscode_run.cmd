@echo off

if not exist vscode (
    echo Folder 'vscode' not found & echo Please install first & ping -n 3 127.0.0.1 >nul & exit
)

set VSCODE_RUN_COMMAND=vscode\bin\code.cmd --reuse-window --extensions-dir vscode/data/extension --user-data-dir vscode/data/user-data

set HOME=%cd%\home
@REM set USERPROFILE=%cd%\home\user-profile
set APPDATA=%cd%\home\user-profile\AppData\Roaming
set LOCALAPPDATA=%cd%\home\user-profile\AppData\Local

set GIT_CEILING_DIRECTORIES=%cd%\playground

set PIP_NO_CACHE_DIR=off

set PATH=%cd%\my_cmds;%cd%\bin;C:\Windows;C:\Windows\System;C:\Windows\System32
set PATH=%cd%\python3;%cd%\python3\Scripts;%PATH%
set PATH=%cd%\git;%cd%\git\cmd;%cd%\git\mingw64\bin;%cd%\git\usr\bin;%PATH%

if exist cuda (
    set PATH=%cd%\cuda\dll\bin;%cd%\cuda\dll\lib;%PATH%
)

@REM %SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -WindowStyle hidden "vscode\bin\code.cmd --reuse-window --extensions-dir vscode/data/extension --user-data-dir vscode/data/user-data"
echo Set WshShell = CreateObject("WScript.Shell") > temp.vbs
echo WshShell.Run """%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"" -NoProfile -Command ""%VSCODE_RUN_COMMAND%""", 0, False >> temp.vbs
cscript //nologo temp.vbs
del temp.vbs

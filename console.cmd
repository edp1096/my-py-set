@echo off

set HOME=%cd%\home
set USERPROFILE=%cd%\home\user-profile
set APPDATA=%cd%\home\app-data

set GIT_CEILING_DIRECTORIES=%cd%\playground

set PIP_NO_CACHE_DIR=off

set PATH=%cd%\my_cmds;%cd%\bin;C:\Windows;C:\Windows\System;C:\Windows\System32
set PATH=%cd%\python3;%cd%\python3\Scripts;%PATH%
set PATH=%cd%\git;%cd%\git\cmd;%cd%\git\mingw64\bin;%cd%\git\usr\bin;%PATH%

if exist cuda ( set PATH=%cd%\cuda\dll\bin;%cd%\cuda\dll\lib;%PATH% )

@rem doskey py=python $*

cmd

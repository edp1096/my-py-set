@echo off


@REM set PYTHON_VERSION=3.10.6
%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -Command "& ./python_get_version.ps1"
set /p PYTHON_VERSION=<PYTHON_VERSION
echo Latest version is %PYTHON_VERSION%


set PATH=%cd%\bin;C:\Windows;C:\Windows\System;C:\Windows\System32
set PATH=%cd%\python3;%cd%\python3\Scripts;%PATH%

set PIP_NO_CACHE_DIR=off
@REM set PIP_TARGET=%cd%\pip\cache

set WORKING_MODE=install

if exist python3 (
	echo Update python
	echo If you want to reinstall, delete 'python3' folder or run 'delete_all.cmd' then run this script again
	
	set WORKING_MODE=update

) else (
	mkdir python3
	mkdir python3\Scripts
)

curl --progress-bar -Lo python3.zip https://www.python.org/ftp/python/%PYTHON_VERSION%/python-%PYTHON_VERSION%-embed-amd64.zip
tar -xf python3.zip --directory=python3

copy python3\python.exe python3\py.exe /y 1>nul

curl --progress-bar -Lo get-pip.py https://bootstrap.pypa.io/get-pip.py
python get-pip.py

del python3.zip 1>nul


echo import site>> python3\python310._pth
echo .\DLLs>> python3\python310._pth
echo .\lib>> python3\python310._pth
echo .\lib\plat-win>> python3\python310._pth
echo .\lib\site-packages>> python3\python310._pth

echo import sys>> python3\sitecustomize.py
echo sys.path.insert(0, '')>> python3\sitecustomize.py

del get-pip.py 1>nul


@REM Not work with >=22.1 so, waive until patch

@REM set PIP_WHEEL_NAME=pip-22.0.4-py3-none-any.whl
@REM set PIP_WHEEL_URL=https://files.pythonhosted.org/packages/4d/16/0a14ca596f30316efd412a60bdfac02a7259bf8673d4d917dc60b9a21812/%PIP_WHEEL_NAME%
@REM set PIP_WHEEL_NAME=pip-22.2.2-py3-none-any.whl
@REM set PIP_WHEEL_URL=https://files.pythonhosted.org/packages/1f/2c/d9626f045e7b49a6225c6b09257861f24da78f4e5f23af2ddbdf852c99b8/%PIP_WHEEL_NAME%

@REM curl --progress-bar -Lo %PIP_WHEEL_NAME% %PIP_WHEEL_URL%
@REM python %PIP_WHEEL_NAME%/pip install --no-index %PIP_WHEEL_NAME%


curl --progress-bar -Lo dev.msi https://www.python.org/ftp/python/%PYTHON_VERSION%/amd64/dev.msi
msiexec /a dev.msi targetdir="%cd%\dev" /qn

if not exist python3\include ( mkdir python3\include )
if not exist python3\libs ( mkdir python3\libs )
xcopy dev\include\* python3\include\* /e/h/y/q 1>nul
xcopy dev\libs\* python3\libs\* /e/h/y/q 1>nul

rmdir dev /q/s 1>nul
del dev.msi /q/s 1>nul


curl --progress-bar -Lo tcltk.msi https://www.python.org/ftp/python/%PYTHON_VERSION%/amd64/tcltk.msi
msiexec /a tcltk.msi targetdir="%cd%\tk_down" /qn

if not exist python3\DLLs ( mkdir python3\DLLs )
xcopy tk_down\DLLs\* python3\DLLs\* /e/h/y/q 1>nul
xcopy tk_down\Lib\tkinter\ python3\Lib\site-packages\tkinter\ /e/h/y/q 1>nul
xcopy tk_down\tcl\tcl8.6\ python3\lib\tcl8.6\ /e/h/y/q 1>nul
xcopy tk_down\tcl\tk8.6\ python3\lib\tk8.6\ /e/h/y/q 1>nul
xcopy tk_down\tcl\tix8.4.3\ python3\lib\tix8.4.3\ /e/h/y/q 1>nul
@REM xcopy tk_down\tcl\reg1.3\ python3\lib\reg1.3\ /e/h/y/q 1>nul
@REM xcopy tk_down\tcl\dde1.4\ python3\lib\dde1.4\ /e/h/y/q 1>nul

rmdir tk_down /q/s 1>nul
del tcltk.msi /q/s 1>nul

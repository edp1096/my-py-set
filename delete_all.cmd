@echo off

rmdir home /q/s 2>nul
rmdir python3 /q/s 2>nul
rmdir cuda /q/s 2>nul
rmdir vscode /q/s 2>nul
rmdir git /q/s 2>nul
del vscode.zip /q/s 2>nul
del git.zip /q/s 2>nul

del "Python Code.lnk" 2>nul
del "%UserProfile%\desktop\Python Code.lnk" 2>nul

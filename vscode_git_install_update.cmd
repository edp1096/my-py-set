@echo off


set NODE_OPTIONS=--throw-deprecation

set WORKING_MODE=install

%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -Command "& ./git_get_version.ps1"
set /p GIT_DOWNLOAD_URL=<GIT_DOWNLOAD_URL


if exist vscode (
    echo Update vscode,  git
    echo If you want to reinstall, delete 'vscode' folder or run 'delete_all.cmd' then run this script again

    set WORKING_MODE=update

    cd vscode

    for /f %%F in ('dir . /b /a-d ^| findstr /vile "data"') do (del "%%F")
    for /f %%D in ('dir /b /ad ^| findstr /vile "data"') do (rmdir "%%D"/q/s)
    
    cd ..

) else (
    echo Install vscode, git
    mkdir vscode
)

curl --progress-bar -Lo vscode.zip https://go.microsoft.com/fwlink/?Linkid=850641
tar -xf vscode.zip --directory=vscode

del vscode.zip /q /s 1>nul

cd vscode

@REM Set webfont
@REM https://stackoverflow.com/a/54124991/8964990
set WORKBENCH_DESKTOP_MAIN_CSS=%cd%\resources\app\out\vs\workbench\workbench.desktop.main.css

echo.>> %WORKBENCH_DESKTOP_MAIN_CSS%
echo @import url("//cdn.jsdelivr.net/gh/wan2land/d2coding/d2coding-ligature-full.css");>> %WORKBENCH_DESKTOP_MAIN_CSS%
echo @import url("http://fonts.cdnfonts.com/css/cascadia-code");>> %WORKBENCH_DESKTOP_MAIN_CSS%


if "%WORKING_MODE%" == "install" (

    if not exist home (
        mkdir home
        mkdir home\user-profile
        mkdir home\user-profile\Desktop
    )

    if not exist data (
        mkdir data
        mkdir data\user-data
        mkdir data\user-data\User
    )

    echo {> data\user-data\User\settings.json
    echo     "update.mode": "none",>> data\user-data\User\settings.json
    echo     "workbench.startupEditor": "none",>> data\user-data\User\settings.json
    echo     "workbench.settings.editor": "json",>> data\user-data\User\settings.json
    echo     "workbench.sideBar.location": "right",>> data\user-data\User\settings.json
    echo     "workbench.editor.autoLockGroups": {>> data\user-data\User\settings.json
    echo         "terminalEditor": false,>> data\user-data\User\settings.json
    echo     },>> data\user-data\User\settings.json
    echo     "telemetry.telemetryLevel": "off",>> data\user-data\User\settings.json
    echo     "editor.fontFamily": "D2Coding, Cascadia Code, Consolas, 'Courier New', monospace",>> data\user-data\User\settings.json
    echo     "editor.fontLigatures": true,>> data\user-data\User\settings.json
    echo     "editor.fontSize": 16.7,>> data\user-data\User\settings.json
    echo     "editor.minimap.enabled": false,>> data\user-data\User\settings.json
    echo     "editor.bracketPairColorization.enabled": true,>> data\user-data\User\settings.json
    echo     "breadcrumbs.enabled": true,>> data\user-data\User\settings.json
    echo     "files.autoSave": "afterDelay",>> data\user-data\User\settings.json
    echo     "window.zoomLevel": -1,>> data\user-data\User\settings.json
    echo     "editor.tokenColorCustomizations": {>> data\user-data\User\settings.json
    echo         "textMateRules": [>> data\user-data\User\settings.json
    echo             {>> data\user-data\User\settings.json
    echo                 "scope": [>> data\user-data\User\settings.json
    echo                     "source.go keyword.package.go",>> data\user-data\User\settings.json
    echo                     "source.go keyword.import.go",>> data\user-data\User\settings.json
    echo                     "source.go keyword.function.go",>> data\user-data\User\settings.json
    echo                     "source.go keyword.type.go",>> data\user-data\User\settings.json
    echo                     "source.go keyword.struct.go",>> data\user-data\User\settings.json
    echo                     "source.go keyword.interface.go",>> data\user-data\User\settings.json
    echo                     "source.go keyword.const.go",>> data\user-data\User\settings.json
    echo                     "source.go keyword.var.go",>> data\user-data\User\settings.json
    echo                     "source.go keyword.map.go",>> data\user-data\User\settings.json
    echo                     "source.go keyword.channel.go",>> data\user-data\User\settings.json
    echo                 ],>> data\user-data\User\settings.json
    echo                 "settings": {>> data\user-data\User\settings.json
    echo                     "fontStyle": "italic">> data\user-data\User\settings.json
    echo                 }>> data\user-data\User\settings.json
    echo             },>> data\user-data\User\settings.json
    echo             {>> data\user-data\User\settings.json
    echo                 "scope": [>> data\user-data\User\settings.json
    echo                     "comment",>> data\user-data\User\settings.json
    echo                     "constant.language",>> data\user-data\User\settings.json
    echo                     "keyword.control",>> data\user-data\User\settings.json
    echo                     "keyword.operator.expression",>> data\user-data\User\settings.json
    echo                     "keyword.other",>> data\user-data\User\settings.json
    echo                     "keyword.operator.new",>> data\user-data\User\settings.json
    echo                     "variable.language",>> data\user-data\User\settings.json
    echo                     "entity.other.attribute-name",>> data\user-data\User\settings.json
    echo                     "storage",>> data\user-data\User\settings.json
    echo                 ],>> data\user-data\User\settings.json
    echo                 "settings": {>> data\user-data\User\settings.json
    echo                     "fontStyle": "italic">> data\user-data\User\settings.json
    echo                 }>> data\user-data\User\settings.json
    echo             },>> data\user-data\User\settings.json
    echo         ]>> data\user-data\User\settings.json
    echo     },>> data\user-data\User\settings.json
    echo     "security.workspace.trust.enabled": false,>> data\user-data\User\settings.json
    echo     "scm.alwaysShowRepositories": true,>> data\user-data\User\settings.json
    echo     "terminal.integrated.cwd": "${workspaceFolder}",>> data\user-data\User\settings.json
    echo    "workbench.iconTheme": "vscode-icons",>> data\user-data\User\settings.json
    echo    "vsicons.dontShowNewVersionMessage": true,>> data\user-data\User\settings.json
    echo    "git.enableSmartCommit": true,>> data\user-data\User\settings.json
    echo    "git.confirmSync": false,>> data\user-data\User\settings.json
    echo    "git.autofetch": true,>> data\user-data\User\settings.json
    echo    "python.formatting.provider": "black",>> data\user-data\User\settings.json
    echo    "python.formatting.blackArgs": [ "--line-length", "120" ],>> data\user-data\User\settings.json
    echo }>> data\user-data\User\settings.json
    
    echo [>> data\user-data\User\keybindings.json
    echo     {>> data\user-data\User\keybindings.json
    echo         "key": "alt+oem_3",>> data\user-data\User\keybindings.json
    echo         "command": "workbench.action.createTerminalEditor">> data\user-data\User\keybindings.json
    echo     }>> data\user-data\User\keybindings.json
    echo ]>> data\user-data\User\keybindings.json

    call bin\code.cmd --extensions-dir .\data\extension --user-data-dir .\data\user-data --install-extension ms-python.python 2>nul
    call bin\code.cmd --extensions-dir .\data\extension --user-data-dir .\data\user-data --install-extension vscode-icons-team.vscode-icons 2>nul

    cd ..

) else (
    cd ..
)

rmdir git /q /s 2>nul
curl --progress-bar -Lo git.zip %GIT_DOWNLOAD_URL%
if not exist git ( mkdir git )
tar -xf git.zip --directory=git

del git.zip /q /s 1>nul

%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -Command "& ./vscode_checksum_fix.ps1"

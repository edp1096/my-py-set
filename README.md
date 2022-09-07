Scripts for portable python toy creation on Windows


## Scripts

* `python_install_update.cmd` - Install or update python >= python 3.9
    * `PYTHON_VERSION` - Environment variable for `python_install_update.cmd`
    * `python_get_version.ps1` - Check and write latest version of python to `PYTHON_VERSION`
* `python_remove_absolute.ps1` - Modify `Scripts/*.exe`
    * It change hexdata from absolute `#!x:\blah\blah\python.exe` to `#!  python.exe` in pip.exe, wheel.exe..

* `delete_all.cmd` - Delete all installed
* `console.cmd` - Command prompt with the python path

* Vscode, Git
    * `vscode_git_install_update.cmd` - Install vscode, git. Update vscode
        * `vscode_checksum_fix.ps1` - For [webfont](https://github.com/Joungkyun/font-d2coding-ligature). <b>Do not run directly<b>
    * `vscode_run.cmd` - Run vscode


## Others

* `MEMO.md` - Python module installation memo
* `playground/` - Workspace for python practice

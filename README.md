Scripts for portable python toy creation on Windows


## Scripts

* `ExecutionPolicy` should be set to `RemoteSigned` and unblock `ps1` files
```powershell
# Check
ExecutionPolicy
# Set as RemoteSigned
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

# Unblock ps1 files
Unblock-File *.ps1
```

* python_install_update.cmd - Install or update python embeddable with Tcl/Tk >= python 3.9
    * PYTHON_VERSION - Environment variable for python_install_update.cmd
    * python_get_version.ps1 - Check and write latest version of python to PYTHON_VERSION
* python_remove_absolute.ps1 - Modify Scripts/*.exe
    * It change hexdata from absolute "#!x:\blah\blah\python.exe" to "#!  python.exe" in pip.exe, wheel.exe..

* delete_all.cmd - Delete all installed
* console.cmd - Command prompt with the python path

* Vscode, Git
    * vscode_git_install_update.cmd - Install vscode, git. Update vscode
        * GIT_DOWNLOAD_URL - Environment variable for vscode_git_install_update.cmd
        * vscode_checksum_fix.ps1 - For [webfont](https://github.com/Joungkyun/font-d2coding-ligature). <b>Do not run directly<b>
    * vscode_run.cmd - Run vscode

* Using `MSVC` for `dlib`, `opencv` installation
    * Run `vs developer command prompt`
    * Move repository root. In my case, did following
    ```cmd
    > d:
    > cd D:\devs\my-py-set
    ```
    * Run `console.cmd`
    * Run `pip install dlib` or `pip install opencv`


## Others

* MEMO.md - Python module installation memo
* playground/ - Workspace for python practice

Scripts for portable python toy creation on Windows


## Run
```powershell
.\install_update_all.ps1
```

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

* python_install_update.ps1 - Install or update python embeddable with Tcl/Tk >= python 3.9
* python_remove_absolute.ps1 - Modify Scripts/*.exe
    * It change hexdata from absolute "#!x:\blah\blah\python.exe" to "#!  python.exe" in pip.exe, wheel.exe..
* delete_all.cmd - Delete all installed
* console.cmd - Command prompt with the python path
* cuda_download.ps1 - Download cuda dll files

* Vscode, Git
    * vscode_git_install_update.ps1 - Install vscode, git. Update vscode
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

# https://stackoverflow.com/a/41707540/8964990
# https://stackoverflow.com/a/59880243/8964990

$cwd = (pwd).path

$targetpath = "$cwd\vscode_run.cmd"
$iconlocation = "$cwd\python-logo.ico"

$Shell = New-Object -ComObject ("WScript.Shell")

$Shortcut = $Shell.CreateShortcut("Python Code.lnk")
$Shortcut.IconLocation = "$iconlocation , 0"
$Shortcut.TargetPath = $targetpath
$Shortcut.WorkingDirectory = "$cwd"

$Shortcut.Save()

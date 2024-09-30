$url = "https://www.python.org/downloads/"
$links = (Invoke-Webrequest -UseBasicParsing $url).Links

$pattern = ">([^<]+)<"
$pythonVersion = ""
foreach($a in $links) {
    if ($a -ne $null -and $a.class -eq "button" -and $a.class -ne $null) {
        if ($a.outerHTML -match $pattern) {
            $pythonVersion = $matches[1].split(" ")[-1]
            break
        }
    }
}

# latest version
write-host "Python version: $pythonVersion"

remove-item -r -force -ea 0 python3
new-item -ea 0 -itemtype directory -path python3 | out-null

import-module bitstransfer

$uri = "https://www.python.org/ftp/python/$pythonVersion/python-$pythonVersion-embed-amd64.zip"
start-bitstransfer -destination python3.zip -source $uri
tar -xf python3.zip -C python3
remove-item -force python3.zip

new-item -ea 0 -itemtype directory -path python3\include | out-null
new-item -ea 0 -itemtype directory -path python3\libs | out-null
$uri = "https://www.python.org/ftp/python/$pythonVersion/amd64/dev.msi"
start-bitstransfer -destination dev.msi -source $uri
msiexec /a dev.msi targetdir="$pwd\dev" /qn
Start-Sleep -Seconds 5
copy-item -r -force -ea 0 dev\include\* python3\include
copy-item -r -force -ea 0 dev\libs\* python3\libs ; remove-item -r -force -ea 0 dev, dev.msi

new-item -ea 0 -itemtype directory -path python3\DLLs | out-null
$uri = "https://www.python.org/ftp/python/$pythonVersion/amd64/tcltk.msi"
start-bitstransfer -destination tcltk.msi -source $uri
msiexec /a tcltk.msi targetdir="$pwd\tk_down" /qn
Start-Sleep -Seconds 5
copy-item -r -force tk_down\DLLs\* python3\DLLs
copy-item -r -force tk_down\Lib\tkinter python3\Lib\site-packages\tkinter
copy-item -r -force tk_down\tcl\tcl8.6 python3\lib\tcl8.6
copy-item -r -force tk_down\tcl\tk8.6 python3\lib\tk8.6
copy-item -r -force tk_down\tcl\tix8.4.3 python3\lib\tix8.4.3
copy-item -r -force tk_down\tcl\reg1.3 python3\lib\reg1.3
copy-item -r -force -ea 0 tk_down\tcl\dde1.4 python3\lib\dde1.4 ; remove-item -r -force -ea 0 tk_down, tcltk.msi

copy-item -force -ea 0 python3\python.exe python3\py.exe | out-null


$env:PIP_NO_CACHE_DIR="off"
$env:Path += ";$pwd\python3;$pwd\python3\Scripts"

$uri = "https://bootstrap.pypa.io/get-pip.py"
start-bitstransfer -destination get-pip.py -source $uri
python3/python ./get-pip.py
remove-item -force -ea 0 get-pip.py


$pyVers = $pythonVersion.split(".")
$pyVer = $pyVers[0]+$pyVers[1]
$pthFile = ".\python3\python$pyVer._pth"
# $pthPaths = "Lib\site-packages"
$pthPaths = "import site"
add-content -path $pthFile -value $pthPaths

$siteCustomFile = "python3\sitecustomize.py"
$siteCustomText = "import sys"+"`n"+"sys.path.insert(0, '')"
add-content -path $siteCustomFile -value $siteCustomText

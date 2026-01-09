$uri = "https://api.github.com/repos/brechtsanders/winlibs_mingw/releases/latest"
$json = Invoke-WebRequest -UseBasicParsing -Uri $uri | ConvertFrom-Json

$asset = $json.assets | Where-Object {
    $_.name -match "posix-seh" -and $_.name -match ".zip" -and
    $_.name -notmatch "llvm" -and $_.name -notmatch ".sha"
}

$mingwDownloadURL = $asset.browser_download_url

# write-output $json.name
# write-output $mingwDownloadURL

import-module bitstransfer

new-item -force -ea 0 -itemtype directory -path mingw | out-null
start-bitstransfer -destination mingw.zip -source $mingwDownloadURL
tar -xf mingw.zip -C mingw
remove-item -force mingw.zip

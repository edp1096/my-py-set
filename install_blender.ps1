$uri = "https://www.blender.org/download/"
$response = Invoke-WebRequest -UseBasicParsing -Uri $uri

# Extract version number and download URL for Windows x64 portable
$pattern = 'blender-(\d+\.\d+\.\d+)-windows-x64\.zip'
if (-not ($response.Content -match $pattern)) {
    write-output "Error: Could not find Blender download link"
    exit 1
}

$version = $matches[1]
$majorMinor = $version -replace '(\d+\.\d+)\..*', '$1'
$blenderDownloadURL = "https://download.blender.org/release/Blender$majorMinor/blender-$version-windows-x64.zip"

write-output "Downloading Blender $version (portable)"
write-output $blenderDownloadURL

import-module bitstransfer

start-bitstransfer -destination blender.zip -source $blenderDownloadURL
tar -xf blender.zip
remove-item -force blender.zip

if (test-path blender) {
    remove-item -force -recurse blender
}

robocopy "blender-$version-windows-x64" blender /E /MOVE /NFL /NDL /NJH /NJS /NC /NS /NP | out-null
remove-item -force -recurse -ea 0 "blender-$version-windows-x64"

new-item -force -itemtype directory -path blender\portable | out-null

write-output "Blender $version installed to ./blender/"

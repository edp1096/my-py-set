$uri = "https://api.github.com/repos/git-for-windows/git/releases/latest"

$json = Invoke-WebRequest -UseBasicParsing -Uri $uri | ConvertFrom-Json

$versions = $json.name.Split()
$version = $versions[$versions.length - 1]

$asset = $json.assets | Where-Object { $_.name -eq "MinGit-$version-busybox-64-bit.zip" }

$downloadURL = $asset.browser_download_url
Write-Output $downloadURL | Out-File -FilePath "GIT_DOWNLOAD_URL" -encoding ASCII

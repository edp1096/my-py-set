$bytes  = [System.IO.File]::ReadAllBytes("vscode\resources\app\out\vs\workbench\workbench.desktop.main.css")
$Hasher = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$md5 = $Hasher.ComputeHash($bytes)
$base64 = [System.Convert]::ToBase64String($md5)

$checksum = $base64.replace("=","")

$json = (Get-Content "vscode\resources\app\product.json" -Encoding UTF8 | Out-String)
$product = ConvertFrom-Json $json

$product.checksums.'vs/workbench/workbench.desktop.main.css' = $checksum
$product | ConvertTo-Json -Compress -Depth 10 | Out-File "vscode\resources\app\product.json" -Encoding UTF8

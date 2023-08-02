$url = "https://www.python.org/downloads/"
$links = (Invoke-Webrequest -UseBasicParsing $url).Links # mshtml.HTMLDocumentClass

$pattern = ">([^<]+)<"
$pythonVersion = ""
foreach($a in $links) {
    if ($a -ne $null -and $a.class -eq "button" -and $a.class -ne $null) {
        if ($a.outerHTML -match $pattern) {
            $pythonVersion = $matches[1].split(" ")[-1]
            Write-Output $pythonVersion | Out-File -FilePath "PYTHON_VERSION" -encoding ASCII
            break
        }
    }
}

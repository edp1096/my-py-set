$url = "https://www.python.org/downloads"
$doc = (Invoke-Webrequest $url).ParsedHTML # mshtml.HTMLDocumentClass
$as = $doc.Links

foreach($a in $as) {
    if ($a.className -eq "button") {
        Write-Output $a.innerText.split(" ")[-1] | Out-File -FilePath "PYTHON_VERSION" -encoding ASCII
        break
    }
}

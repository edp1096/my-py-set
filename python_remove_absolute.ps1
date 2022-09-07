echo "This will change hex data from '#!C:\..\python.exe' to '#! python.exe' in all python3/Scripts/*.exe files"
Write-Host -NoNewLine "Press Ctrl+C to stop or Press any key to continue.."
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
echo ""

# https://stackoverflow.com/a/20935550/8964990
# https://stackoverflow.com/a/62511302/8964990
function Find-Bytes([byte[]]$Bytes, [byte[]]$Search, [int]$Start, [Switch]$All) {
    for ($Index = $Start; $Index -le $Bytes.Length - $Search.Length ; $Index++) {
        for ($i = 0; $i -lt $Search.Length -and $Bytes[$Index + $i] -eq $Search[$i]; $i++) {}
        if ($i -ge $Search.Length) {
            $Index
            if (!$All) { return }
        }
    }
}

function Replace-Bytes([string]$fname) {
    $bytes  = [System.IO.File]::ReadAllBytes($fname)
    $find = [byte[]]("#!".ToCharArray() + [char]0x00)
    $pos = Find-Bytes -all $bytes $find
    if (!$pos) {
        Write-Host "Not found"
        continue
    }

    $pos = $pos[$pos.Count - 1]
    $find_head = [byte[]]("#!".ToCharArray())
    $catch_head = Find-Bytes -all $bytes $find_head $pos
    if (!$catch_head) {
        Write-Host "Not found #!...python.exe"
        continue
    }
    $catch_head = $catch_head[$catch_head.Count - 1]

    $find_py = [byte[]]("python.exe".ToCharArray())
    $catch_py = Find-Bytes $bytes $find_py $pos
    if (!$catch_py) {
        Write-Host "Not found python.exe"
        continue
    }
    $catch_py = $catch_py[$catch_py.Count - 1]

    $begin = ($catch_head + 2)
    $end = ($catch_py - 1)
    $beginh = [System.Convert]::ToString($begin,16)
    $endh = [System.Convert]::ToString($end,16)

    echo "begin: $beginh  end: $endh  file: $fname"

    for ($i = $begin; $i -le $end; $i++) {
        $bytes[$i] = 0x20
    }

    [System.IO.File]::WriteAllBytes($fname, $bytes)
}

function main() {
    $ScriptRoot = "python3/Scripts"
    Get-ChildItem $ScriptRoot -Include "*.exe" -Recurse  | Where-Object { -not $_.PSIsContainer } |
    ForEach-Object { Replace-Bytes($_.FullName) }
}

main

echo "Done"

exit

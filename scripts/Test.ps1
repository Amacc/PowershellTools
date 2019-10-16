Get-ChildItem .\src\*.Test\ -r |
    ForEach-Object{ & $_.FullName }

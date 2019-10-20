#Requires -Module Pester

Get-ChildItem .\src\*.Test\ -r |
    ForEach-Object { & $_.FullName }

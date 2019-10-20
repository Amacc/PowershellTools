#Requires -Module @{ModuleName="Pester";ModuleVersion=4.9.0}

Get-ChildItem .\src\*.Test\ -r |
    ForEach-Object { & $_.FullName }

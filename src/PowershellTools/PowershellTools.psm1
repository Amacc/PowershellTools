@(
    "$PSScriptRoot\functions"
) | Get-ChildItem | ForEach-Object { . $_.FullName }

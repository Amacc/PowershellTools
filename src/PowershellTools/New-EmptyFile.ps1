
Function New-EmptyFile {
    $args |
        ForEach-Object { Set-Content -Path $_  -Encoding ascii -Value $null }
}

New-Alias -Force touch New-EmptyFile

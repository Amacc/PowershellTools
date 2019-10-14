Function ConvertFrom-Base64 {
    [cmdletbinding()]param(
        [Parameter(ValueFromPipeline)]
        [string] $Input
    )
    process {
        Write-Verbose $Input
        [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($Input))
    }
}

Export-ModuleMember -Function ConvertFrom-Base64

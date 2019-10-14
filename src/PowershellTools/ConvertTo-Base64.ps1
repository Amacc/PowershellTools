Function ConvertTo-Base64 {
    param(
        [Parameter(ValueFromPipeline)]
        [String] $Input
    )
    process{
        $b = [System.Text.Encoding]::UTF8.GetBytes($Input)
        return [System.Convert]::ToBase64String($b)
    }
}

Export-ModuleMember -Function ConvertFrom-Base64

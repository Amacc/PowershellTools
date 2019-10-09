ConvertFrom-Base64 {
    param([Parameter(ValueFromPipeline)]$Input)
    [System.Text.Encoding]::UTF8.GetString([system.convert]::FromBase64String($Input))
}

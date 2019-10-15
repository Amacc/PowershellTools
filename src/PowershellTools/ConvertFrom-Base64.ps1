Function ConvertFrom-Base64 {
    <#
        .SYNOPSIS
        Decode Base64 encoded string

        .DESCRIPTION
        Helper function to manage base64 encoded strings
    #>
    [cmdletbinding()]param(
        [Parameter(ValueFromRemainingArguments)]
        [string] $Input,
        [Parameter(ValueFromPipeline)]
        [string] $PipelineInput
    )
    begin {
        if($Input){ return $Input | ConvertFrom-Base64 }
    }
    process {
        [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($PipelineInput))
    }
}

Export-ModuleMember -Function ConvertFrom-Base64

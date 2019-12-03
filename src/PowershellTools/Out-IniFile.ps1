function Out-KVPString {
    param (
        [Parameter(ValueFromPipelineByPropertyName)][string] $Name,
        [Parameter(ValueFromPipelineByPropertyName,Mandatory)][string] $Value,
        [string] $Seperator = "="
    )
    process {"$Name$Seperator$Value" }
}

Function Out-TOML{
    param(
        [Parameter(ValueFromPipelineByPropertyName)][string] $Name,
        [Parameter(ValueFromPipelineByPropertyName)][hashtable] $Value
    )
    process {
        "[$Name]"                            # Emit Header
        $Value.GetEnumerator() |
            Out-KVPString                    # Emit key=value
        ""                                   # Emit empty line
    }
}


Function Out-IniFile {
    <#
    .Synopsis
        Write hash content to INI file

    .Parameter InputObject
        The hasthable to be written to the provided filepath.

    .Parameter FilePath
        Specifies the file output path.

    .Parameter Encoding
        Specifies the type of character encoding used in the file. Default Ascii

    .Example

        $NewINIContent = @{
            “Category1”=@{“Key1”=”Value1”;”Key2”=”Value2”}
            ”Category2”=@{“Key1”=”Value1”;”Key2”=”Value2”}
        }
        Out-IniFile -InputObject $NewINIContent -FilePath testfile.ini
        -----------
        Description
        Creates a hashtable and saves it to testfile.ini in the current directory

    .Link
        Get-IniContent
    #>

    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory = $True)]
        [string] $FilePath,
        [switch] $Append,

        [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]
        $Encoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Ascii,

        [ValidateNotNullOrEmpty()]
        [Parameter(ValueFromPipeline = $True, Mandatory = $True)]
        [Hashtable]$InputObject
    )
    process {
        if(( -not $Append ) -and ( Test-Path $FilePath )){
            Throw "File Exists and not set to append"
        }
        $InputObject.GetEnumerator() |    # Split the input item by key value pairs
            Out-TOML |
            Foreach-Object {              # Write the emitted strings to file
                Add-Content -Path $FilePath -Value $_
            }
    }
}

Export-ModuleMember -Function Out-IniFile, Out-TOML, Out-KVPString

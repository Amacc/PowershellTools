Import-Module $PSScriptRoot/../PowershellTools/PowershellTools.psm1

Describe 'ConvertFrom-Base64' {
    it "returns a base64 decoded string based on the given input" {
        ConvertFrom-Base64 "Zm9v" | Should -Match "foo"
    }
    it "returns a base64 decoded string based on the pipeline input" {
        "Zm9v" | ConvertFrom-Base64 | Should -Match "foo"
    }
}

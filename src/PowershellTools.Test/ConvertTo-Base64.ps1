Import-Module $PSScriptRoot/../PowershellTools/PowershellTools.psm1

Describe 'ConvertTo-Base64' {
    it "returns a base64 encoded string based on the given input" {
        ConvertTo-Base64 "foo" | Should -Match "Zm9v"
    }
    it "returns a base64 encoded string based on the pipeline input" {
        "foo" | ConvertTo-Base64 | Should -Match "Zm9v"
    }
}

Import-Module $PSScriptRoot/../PowershellTools/PowershellTools.psd1

Describe 'New-EmptyFile' {
    InModuleScope "PowershellTools" {
        Import-Module $PSScriptRoot/../PowershellTools/PowershellTools.psd1
        it "creates an empty file at the target location" {
            $file_location = "somefile"
            Mock -Module PowershellTools Set-Content { } -Verifiable `
                -ParameterFilter { $value -eq $Null -and $path -eq $file_location }

            New-EmptyFile $file_location

            Assert-VerifiableMock
        }
        it "creates new file without the bom" {
            $file_location = "somefile"
            Mock -Module PowershellTools Set-Content -Verifiable

            New-EmptyFile $file_location

            Assert-MockCalled Set-Content -ParameterFilter { $encoding -eq 'Ascii' }
        }
        # it "can be invoked with alias touch" {
        #     $file_location = "somefile"
        #     Mock -Module PowershellTools Set-Content { } -Verifiable `
        #         -ParameterFilter { $path -eq $file_location }

        #     touch $file_location

        #     Assert-VerifiableMock
        # }
    }
}

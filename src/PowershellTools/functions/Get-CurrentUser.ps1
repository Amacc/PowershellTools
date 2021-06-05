
Function Get-CurrentUser{
    return `
        [Security.Principal.WindowsPrincipal]`
        [Security.Principal.WindowsIdentity]::GetCurrent()
}

Function Test-UserGroupMembership{
    param(
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Security.Principal.WindowsPrincipal]
        [Security.Principal.WindowsIdentity]
        $User,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string] $Group
    )
    process{
        return $User.IsInRole($Group)
    }
}

Export-ModuleMember -Function Get-CurrentUser, Test-UserGroupMembership

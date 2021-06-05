
Function Compress-FilesByDate {
    [CmdletBinding()]
    param(
        # Source Directory to archive files from
        [Parameter(Position=0)]
        [String] $Source,

        # Destination to create the Zip in
        [Parameter(Position=1)]
        [String] $Destination,

        # File Suffix
        [Parameter(Position=2)]
        [String] $Suffix,

        # Whether to create the archive by year
        [Switch] $ByYear,

        # Whether to create the archive by month
        [Switch] $ByMonth,

        # Whether to create the archive by day
        [Switch] $ByDay,

        # Whether to remove the file after archiving it
        [Switch] $RemoveAfterArchive
    )
    if(![Boolean](@($ByYear,$ByMonth,$ByDay)|Where-Object{$_})){
        throw "No Archive Flags specified"
    }

    Get-ChildItem $Source -File |
        ForEach-Object {
            $archiveName = (@(
                if($ByYear){$_.LastWriteTime.Year}
                if($ByMonth){$_.LastWriteTime.Month}
                if($ByDay){$_.LastWriteTime.Day}
                $Suffix
            ) | Where-Object {$_}) -join "-"

            $compressParams = @{
                DestinationPath = "$Destination/$archiveName.zip"
                Update = Test-Path "$Destination/$archiveName.zip"
                Path = $_.FullName
            }
            Compress-Archive @compressParams

            if($RemoveAfterArchive){Remove-Item $_.FullName}
        }
}

Export-ModuleMember -Function Compress-FilesByDate

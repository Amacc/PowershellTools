Function New-XamlUI {
    param(
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Xaml
    )
    process{        
        $reader=(New-Object System.Xml.XmlNodeReader $xaml)
        $Form=[Windows.Markup.XamlReader]::Load( $reader )
        $xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}
    }
}
$reader=(New-Object System.Xml.XmlNodeReader $xaml)
try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Some possible causes for this problem include: .NET Framework is missing PowerShell must be launched with PowerShell -sta, invalid XAML code was encountered."; exit}

#===========================================================================
# Store Form Objects In PowerShell
#===========================================================================
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}

#===========================================================================
# Add events to Form Objects
#===========================================================================
$btnExit.Add_Click({$form.Close()})

#===========================================================================
# Stores WMI values in WMI Object from Win32_Operating System Class
#===========================================================================
$oWMIOS = Get-WmiObject win32_OperatingSystem

#===========================================================================
# Links WMI Object Values to XAML Form Fields
#===========================================================================
$txtHostName.Text = $oWMIOS.PSComputerName

#Formats and displays OS name
$aOSName = $oWMIOS.name.Split("|")
$txtOSName.Text = $aOSName[0]

#Formats and displays available memory
$sAvailableMemory = [math]::round($oWMIOS.freephysicalmemory/1000,0)
$sAvailableMemory = "$sAvailableMemory MB"
$txtAvailableMemory.Text = $sAvailableMemory

#Displays OS Architecture
$txtOSArchitecture.Text = $oWMIOS.OSArchitecture

#Displays Windows Directory
$txtWindowsDirectory.Text = $oWMIOS.WindowsDirectory

#Displays Version
$txtWindowsVersion.Text = $oWMIOS.Version

#Displays System Drive
$txtSystemDrive.Text = $oWMIOS.SystemDrive

#===========================================================================
# Shows the form
#===========================================================================
$Form.ShowDialog() | out-null



# From https://mcpmag.com/articles/2016/04/28/building-ui-using-powershell.aspx 
# $xaml.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]")  | ForEach {
#         New-Variable  -Name $_.Name -Value $Window.FindName($_.Name) -Force 
#     } 
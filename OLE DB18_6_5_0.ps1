<# 

1: Checks for software and software version 
2: Installs software


#>


$ErrorActionPreference = "SilentlyContinue"

# EG URL is the download URL
$URL = "https://github.com/itgau/pubinstall/raw/main/msoledbsql.msi?download="

# EG "C:\Temp\Test.msi"
$Installdir = "c:\temp\msoledbsql.msi"  

# EG "FortiVPN"
$Softwarename = "Microsoft OLE DB Driver for SQL Server"

# EG "17.1.1"
$Version = "18.6.5.0"


try {
    $Driver = Get-WmiObject -Class Win32_Product | Where-object Name -Like "$SoftwareName*"
    $DriverVer = ($Driver).version
    $DriverID = ($Driver).Identifyingnumber

    if ($DriverVer -like "$Version*" ) {
        Write-Host = "$DriverVer is already installed"
        exit

    }

    else { 
        Invoke-WebRequest -URI $URL -OutFile $Installdir
        start-process msiexec.exe -ArgumentList "/i $Installdir IACCEPTMSOLEDBSQLLICENSETERMS=YES /qn " -wait 
        Write-host "$Softwarename has been installed"
        Remove-Item -Path $Installdir -Force
    }
}


catch { 
    Write-Error "Error exiting script"
    exit 
}
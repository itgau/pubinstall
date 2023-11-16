<# 

1: Checks for software and software version 
2: Installs software


#>


$ErrorActionPreference = "SilentlyContinue"

# EG URL is the download URL
$URL = "https://github.com/itgau/pubinstall/raw/main/msodbcsql 17.10.5.1.msi?download="

# EG "C:\Temp\Test.msi"
$Installdir = "c:\temp\msodbcsql 17.10.5.1.msi"  

# EG "FortiVPN"
$Softwarename = "Microsoft ODBC Driver 17 for SQL Server"

# EG "17.1.1"
$Version = "17.10.5.1"


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
        start-process msiexec.exe -ArgumentList "/i $Installdir /qn" -wait 
        Write-host "$Softwarename has been installed"
        Remove-Item -Path $Installdir -Force
    }
}


catch { 
    Write-Error "Error exiting script"
    exit 
}
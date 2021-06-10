<#
This simple script downloads and installs Chrome, and sets it as default browser of OS. All in background.
* start as admin mode *

Author: Matheus Rocha
Country: Brazil
GitHub: /roch4
LinkedIn: /roch4

Reference to Default Browser: https://cutt.ly/unkYeEm
#>


#Creating 'temp' DIR in C: if don't exist
$path = 'C:\temp'
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}
#END temp


#INSTALL CHROME:

Invoke-WebRequest http://dl.google.com/chrome/install/375.126/chrome_installer.exe -OutFile 'C:\temp\GoogleChrome.exe' #Chrome download
C:\temp\GoogleChrome.exe /silent /install #Chrome install in background
sleep 240


#CHROME DEFAULT BROWSER:

Invoke-WebRequest https://kolbi.cz/SetDefaultBrowser.zip -OutFile 'C:\temp\default-browser.zip' #SetDefaultBrowser.zip download

#Unzip SetDefaultBrowse
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip{
    param([string]$zipfile, [string]$outpath)
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}
Unzip 'C:\temp\default-browser.zip' 'C:\temp\' #unzip in SetDefaultBrowser DIR
#END Unzip

cd 'C:\temp\SetDefaultBrowser' #SetDefaultBrowser.exe DIR
.\SetDefaultBrowser.exe HKLM "Google Chrome" #SetDefaultBrowser.exe start like Chrome

#removing install files
Remove-Item 'C:\temp\GoogleChrome.exe' , 'C:\temp\default-browser.zip' -Recurse -Force -Confirm:$false
# Description: Boxstarter Script
# Author: Microsoft
# Common settings for web dev

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
# executeScript "SystemConfiguration.ps1";
executeScript "CommonDevTools.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "HyperV.ps1";
executeScript "Docker.ps1";
executeScript "WSL.ps1";
executeScript "Browsers.ps1";
executeScript "DotNetFrameworks.ps1";

#--- Tools ---
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension msjsdiag.debugger-for-edge

choco install -y nodejs-lts # Node.js LTS, Recommended for most users
choco install -y visualstudio2019community --package-parameters="'--add Microsoft.VisualStudio.Component.Git --add Microsoft.VisualStudio.Workload.ManagedDesktop --add Microsoft.VisualStudio.Workload.NetWeb --add Microsoft.VisualStudio.Workload.NetCoreTools'"
choco install -y visualstudio2019buildtools
choco install -y sql-server-management-studio
choco install -y postman

#--- Microsoft WebDriver ---
choco install -y microsoftwebdriver

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula

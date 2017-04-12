#function Get-MyModule
#ref: http://blogs.technet.com/b/heyscriptingguy/archive/2010/07/11/hey-scripting-guy-weekend-scripter-checking-for-module-dependencies-in-windows-powershell.aspx
Function Get-MyModule
{ 
	Param([string]$name) 
	if(-not(Get-Module -name $name)) 
	{
		#if module available then import 
		if(Get-Module -ListAvailable | 
			Where-Object { $_.name -eq $name }) { 
				Import-Module -Name $name 
				$true
		} else {
			#module not available 
			$false
		}
	#if not module 
	} else {
		#module already loaded 
		$true
	}
}

# Powershell Aliases
if(Test-Path "$Home\Documents\WindowsPowerShell\aliases.ps1") {
	. "$Home\Documents\WindowsPowerShell\aliases.ps1"
}

## Powershell Modules

# Source: https://github.com/psget/psget
if(-not(Get-MyModule "PsGet")) {
	(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

if(-not(Get-MyModule "posh-git")) {
	Install-Module posh-git | Wait-Job
}

# Load posh-git example profile
#. "$Env:USERPROFILE\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1"

# Load Oh-My-Powershell
$ohMyPowershellMod = Get-Module -List "oh-my-posh"
if(!$ohMyPowershellMod) {
    # Source: https://github.com/pecigonzalo/Oh-My-Posh
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/pecigonzalo/Oh-My-Posh/master/install.ps1") | iex
}

Import-Module "oh-my-posh" -DisableNameChecking -NoClobber

# Add to Path
$env:Path += ";$env:USERPROFILE\AppData\Roaming\npm"
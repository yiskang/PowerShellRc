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
#Source: https://github.com/psget/psget
if(-not(Get-MyModule "PsGet")) {
	(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
} else {
	#source: https://github.com/dahlbyk/posh-git
	if(-not(Get-MyModule "posh-git")) {
		Install-Module posh-git
	} else {
		# Load posh-git example profile
		. "$Env:USERPROFILE\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1"
	}

	#Source: https://github.com/lzybkr/PSReadLine
	if(-not(Get-MyModule "PSReadline")) {
		Install-Module PSReadline
	} else {
		if ($host.Name -eq 'ConsoleHost') {
			Import-Module PSReadLine
		}
	}
}

#Powershell Aliases
if(Test-Path "$Home\Documents\WindowsPowerShell\aliases.ps1") {
	. "$Home\Documents\WindowsPowerShell\aliases.ps1"
}
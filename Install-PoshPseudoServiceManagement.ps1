function Install-PoshPseudoServiceManagement
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param ()

	$powershellModulePaths = @($env:PSModulePath -split ';')

	$installationDirectory = "PoshPseudoServiceManagement"
	$installationPath = ""
	foreach ($path in $powershellModulePaths)
	{
		if ($path -match ":\\Users")
		{
			Write-Verbose -Message ("The user has a path for modules this machine at [${path}].")
			$installationPath = $path
			break;
		}

		Write-Verbose -Message ("Selecting [${path}] as the general location for scripts.")
		$installationPath = $path
	}

	if ([System.string]::IsNullOrEmpty($installationPath))
	{
		Write-Verbose -Message ("An installation directory for the module could not be found.")
		return $false
	}

	Write-Verbose -Message ("${installationPath}\${installationDirectory}")
	New-Item -ItemType Directory -Path ("${installationPath}\${installationDirectory}") -Force
}

Install-PoshPseudoServiceManagement -Verbose -Confirm
.PHONY: publish update validate

publish: validate
	@powershell Publish-Module -Path (Get-Location) -NuGetApiKey $$ENV:NUGET_API_KEY -Verbose

update:
	powershell Install-Module -Name PowerShellGet -RequiredVersion 2.2.1 -Force

validate:
	@powershell Test-ModuleManifest -Path (Join-Path (Get-Location) pwsh-handy-helpers.psd1)
	@powershell if ((Write-Output $$ENV:NUGET_API_KEY).Length -eq 46) { Write-Output "Valid: NUGET_API_KEY" }
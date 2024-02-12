<#
Exchange Online only works if you install wsman as sudo:
    
    Install-Module -Name ExchangeOnlineManagement
    pwsh -Command 'Install-Module -Name PSWSMan'
    sudo pwsh -Command 'Install-WSMan'



Update-Module Az
Update-Module MicrosoftTeams
#>
Set-PSRepository PSGallery -InstallationPolicy Trusted


#Install-Module SharePointPnPPowerShellOnline

#Write-Host "SharePoint PnP Login: Connect-PnPOnline -Url https://yoursite.sharepoint.com -UseWebLogin "
$env:PATH = "/Users/justinhibbard/google-cloud-sdk/bin:" + $env:PATH




function Get-MSGodmode {

#	Update-Module Microsoft.Graph
	Connect-MgGraph -Scopes "RoleManagement.ReadWrite.Directory"
	Get-MgRoleManagementDirectoryRoleAssignmentScheduleInstance -Filter "principalId eq 'e7f30563-5dd0-4f30-ba4c-c109f074e435'" | Format-List



}

function Activate-MSGodmode {
	$godmodeparams = @{
	  "PrincipalId" = 'e7f30563-5dd0-4f30-ba4c-c109f074e435' #this is the object id for my admin account
	  "RoleDefinitionId" = "62e90394-69f5-4237-9190-012177145e10"
	  "Justification" = "Activate assignment"
	  "DirectoryScopeId" = "/"
	  "Action" = "SelfActivate"
	  "ScheduleInfo" = @{
	    "StartDateTime" = Get-Date
	    "Expiration" = @{
	       "Type" = "AfterDuration"
	       "Duration" = "PT1H"
	       }
	     }
	    }
#	Update-Module Microsoft.Graph
	Connect-MgGraph -Scopes "RoleManagement.ReadWrite.Directory"
	New-MgRoleManagementDirectoryRoleAssignmentScheduleRequest -BodyParameter $godmodeparams
}

function Deactivate-MSGodmode {

	$godmodeparams = @{
	  "PrincipalId" = 'e7f30563-5dd0-4f30-ba4c-c109f074e435'
	  "RoleDefinitionId" = "62e90394-69f5-4237-9190-012177145e10"
	  "Justification" = "Deactivate assignment"
	  "DirectoryScopeId" = "/"
	  "Action" = "SelfDeactivate"
	    }
	Connect-MgGraph -Scopes "RoleManagement.ReadWrite.Directory"
	New-MgRoleManagementDirectoryRoleAssignmentScheduleRequest -BodyParameter $godmodeparams
	
}

function Get-BoltPlan {
    <#
    .SYNOPSIS
    Get all bolt plans available to Puppet Bolt
    .DESCRIPTION
    This function will read available plans or details
    on specific plans. Puppet Bolt is an agentless automation
    solution for running ad-hoc tasks and operations on remote targets
    .LINK
    https://puppet.com/products/bolt
    .LINK
    https://puppet.com/docs/bolt/latest/bolt_running_plans.html
    .LINK
    https://puppet.com/docs/bolt/latest/bolt_command_reference.html
    .PARAMETER PlanNames
    Names of the bolt plans to show details on
    .PARAMETER ModulePath
    List of directories containing modules, separated by ';'
    .PARAMETER BoltDir
    Specify what Boltdir to load config from (default: autodiscovered from current working dir)
    .PARAMETER ConfigFile
    Specify where to load config from (default: ~/.puppetlabs/bolt/bolt.yaml)
    #>
    [CmdletBinding()]
    param(
        [Alias("plans")]
        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,Position=0)]
        [string[]]  $PlanNames,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $ModulePath,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $BoltDir,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $ConfigFile
    )
    process {
        try {
            $bolt_params = ConvertTo-BoltParameters @PSBoundParameters
            if ($PlanNames) {
                foreach($plan in $PlanNames) {
                    Invoke-BoltInternal -BoltCommandLine "plan show $plan $bolt_params" | Write-Output
                }
            } else {
                Invoke-BoltInternal -BoltCommandLine "plan show $bolt_params" | Write-Output
            }
        } catch {
            Write-Error $_
        }
    }
}

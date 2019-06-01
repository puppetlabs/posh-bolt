function Get-BoltTask {
    <#
    .SYNOPSIS
    Read tasks available to Puppet Bolt
    .DESCRIPTION
    This function will get available bolt tasks or details
    on a specific task. Puppet Bolt is an agentless automation
    solution for running ad-hoc tasks and operations on remote targets
    .LINK
    https://puppet.com/products/bolt
    .LINK
    https://puppet.com/docs/bolt/latest/bolt_running_tasks.html
    .LINK
    https://puppet.com/docs/bolt/latest/bolt_command_reference.html
    .PARAMETER TaskNames
    Names of the bolt tasks to show details on
    .PARAMETER ModulePath
    List of directories containing modules, separated by ';'
    .PARAMETER BoltDir
    Specify what Boltdir to load config from (default: autodiscovered from current working dir)
    .PARAMETER ConfigFile
    Specify where to load config from (default: ~/.puppetlabs/bolt/bolt.yaml)
    #>
    [CmdletBinding()]
    param(
        [Alias("tasks")]
        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,Position=0)]
        [string[]]  $TaskNames,

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
            if ($TaskNames) {
                foreach($task in $TaskNames) {
                    Invoke-BoltInternal -BoltCommandLine "task show $task $bolt_params" | Write-Output
                }
            } else {
                Invoke-BoltInternal -BoltCommandLine "task show $bolt_params" | Write-Output
            }
        } catch {
            Write-Error $_
        }
    }
}

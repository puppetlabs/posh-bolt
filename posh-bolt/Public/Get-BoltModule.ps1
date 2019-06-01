function Get-BoltModule {
    <#
    .SYNOPSIS
    Get all modules available to Puppet Bolt
    .DESCRIPTION
    This function will list all available modules to bolt.
    Puppet Bolt is an agentless automation solution for running ad-hoc
    tasks and operations on remote targets
    .LINK
    https://puppet.com/products/bolt
    .PARAMETER ModulePath
    Directories containing modules, separated by ';'
    .PARAMETER BoltDir
    Specify what Boltdir to load config from (default: autodiscovered from current working dir)
    .PARAMETER ConfigFile
    Specify where to load config from (default: ~/.puppetlabs/bolt/bolt.yaml)
    #>
    [CmdletBinding()]
    param(
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
            Invoke-BoltInternal -BoltCommandLine "puppetfile show-modules $bolt_params" | Write-Output
        } catch {
            Write-Error $_
        }
    }
}

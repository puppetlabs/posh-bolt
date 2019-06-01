function Install-BoltModule {
    <#
    .SYNOPSIS
    Install bolt modules from puppetfile
    .DESCRIPTION
    This function will install any modules required in the puppetfile. Puppet Bolt is an agentless automation
    solution for running ad-hoc tasks and operations on remote targets
    .LINK
    https://puppet.com/products/bolt
    .LINK
    https://puppet.com/docs/bolt/latest/bolt_installing_modules.html#install-modules
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
            Invoke-BoltInternal -BoltCommandLine "puppetfile install $bolt_params" | Write-Output
        } catch {
            Write-Error $_
        }
    }
}

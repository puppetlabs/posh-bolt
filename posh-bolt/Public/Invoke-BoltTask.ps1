function Invoke-BoltTask {
    <#
    .SYNOPSIS
    Execute Puppet Bolt task
    .DESCRIPTION
    This function will execute bolt tasks on the targets specified by the -Targets
    or -Queries parameter. Puppet Bolt is an agentless automation
    solution for running ad-hoc tasks and operations on remote targets
    .LINK
    https://puppet.com/products/bolt
    .LINK
    https://puppet.com/docs/bolt/latest/writing_tasks_and_plans.html
    .LINK
    https://puppet.com/docs/bolt/latest/bolt_running_tasks.html
    .LINK
    https://puppet.com/docs/bolt/latest/writing_tasks.html
    .PARAMETER TaskNames
    The names of the bolt tasks to execute
    .PARAMETER Targets
    Identifies the targets to execute on.

    Enter a string with a comma-separated list of node URIs or group names to have bolt
    execute on multiple targets at once

    Example: -Targets "localhost,node_group,ssh://nix.com:23,winrm://windows.puppet.com"
    * URI format is [protocol://]host[:port]
    * SSH is the default protocol; may be ssh, winrm, pcp, local, docker, remote
    * For Windows nodes, specify the winrm:// protocol if it has not be configured
    * For SSH, port defaults to `22`
    * For WinRM, port defaults to `5985` or `5986` based on the --[no-]ssl setting
    .PARAMETER Queries
    PuppetDB Queries to determine the targets
    .PARAMETER Parameters
    Parameters to a task or plan as:
    * a valid json string
    * powershell HashTable
    * a json file: '@<file>'

    .PARAMETER Rerun
    Retry on nodes from the last run
    * 'all' all nodes that were part of the last run.
    * 'failure' nodes that failed in the last run.
    * 'success' nodes that succeeded in the last run.
    .PARAMETER Noop
    Execute a task that supports it in noop mode
    .PARAMETER Description
    Description to use for the job
    .PARAMETER Username
    User to authenticate as
    .PARAMETER Password
    Password to authenticate with. Omit the value to prompt for the password.
    .PARAMETER SSHPrivateKey
    Private ssh key to authenticate with
    .PARAMETER HostKeyCheck
    Check host keys with SSH
    .PARAMETER SSL
    Use SSL with WinRM
    .PARAMETER SSLVerify
    Verify remote host SSL certificate with WinRM
    .PARAMETER RunAs
    User to run as using privilege escalation
    .PARAMETER SudoPassword
    Password for privilege escalation. Omit the value to prompt for the password.
    .PARAMETER Concurrency
    Maximum number of simultaneous connections (default: 100)
    .PARAMETER CompileConcurrency
    Maximum number of simultaneous manifest block compiles (default: number of cores)
    .PARAMETER ModulePath
    List of directories containing modules, separated by ';'
    .PARAMETER BoltDir
    Specify what Boltdir to load config from (default: autodiscovered from current working dir)
    .PARAMETER ConfigFile
    Specify where to load config from (default: ~/.puppetlabs/bolt/bolt.yaml)
    .PARAMETER InventoryFile
    Specify where to load inventory from (default: ~/.puppetlabs/bolt/inventory.yaml)
    .PARAMETER SaveRerun
    Whether to update the rerun file after this command.
    .PARAMETER Transport
    Specify a default transport: ssh, winrm, pcp, local, docker, remote
    .PARAMETER ConnectTimeout
    Connection timeout (defaults vary)
    .PARAMETER TTY
    Request a pseudo TTY on targets that support it
    .PARAMETER Tmpdir
    The directory to upload and execute temporary files on the target
    #>
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string[]]  $TaskNames,

        [parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='Target')]
        [string[]]  $Targets,

        [parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='Query')]
        [string[]]  $Queries,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [object]  $Parameters,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [BoltRerunTypes]  $Rerun,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [switch] $Noop,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $Description,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [bool]    $SSL=$true,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [bool]    $SSLVerify=$true,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [bool]    $HostKeyCheck=$true,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $Username,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $Password,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $SSHPrivateKey,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $RunAs,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $SudoPassword,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [int]     $Concurrency,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [int]     $CompileConcurrency,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $ModulePath,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $BoltDir,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $ConfigFile,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $InventoryFile,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [bool]    $SaveRerun=$false,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $Transport,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [int]     $ConnectTimeout,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [bool]    $TTY=$false,

        [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]  $Tmpdir
    )
    process {
        try {
            $bolt_params = ConvertTo-BoltParameters @PSBoundParameters
            foreach($task in $TaskNames) {
            if ($Targets) {
                    foreach ($target in $Targets) {
                        Invoke-BoltInternal -BoltCommandLine "task run $TaskNames --targets=$target $bolt_params" | Write-Output
                    }
                } else {
                    foreach ($query in $Queries) {
                        Invoke-BoltInternal -BoltCommandLine "task run $TaskNames --query=$query $bolt_params" | Write-Output
                    }
                }
            }
        } catch {
            Write-Error $_
        }
    }
}

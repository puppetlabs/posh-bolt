function ConvertTo-BoltParameters {
    <#
    .SYNOPSIS
    This is an internal-only function used to parse powershell parameters to CLI flags
    for bolt. ConvertTo-BoltParameters takes all possible parameters optionally from
    any of the other bolt functions so that the other functions can pass @PSBoundParameters
    rather than each param one at a time.

    parameters for ConvertTo-BoltParameters does not use ValueFromPipelineByPropertyName
    intentionally, since this function is designed to only run once and produce a single
    parameter string. Pipelines should be supported by the functions that call
    ConvertTo-BoltParameters
    #>
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$false)]
        [object]  $Parameters,

        [parameter(Mandatory=$false)]
        [BoltRerunTypes]  $Rerun,

        [parameter(Mandatory=$false)]
        [switch]  $Noop,

        [parameter(Mandatory=$false)]
        [string]  $Description,

        [parameter(Mandatory=$false)]
        [bool]    $SSL,

        [parameter(Mandatory=$false)]
        [bool]    $SSLVerify,

        [parameter(Mandatory=$false)]
        [bool]    $HostKeyCheck=$true,

        [parameter(Mandatory=$false)]
        [string]  $Username,

        [parameter(Mandatory=$false)]
        [string]  $Password,

        [parameter(Mandatory=$false)]
        [string]  $SSHPrivateKey,

        [parameter(Mandatory=$false)]
        [string]  $RunAs,

        [parameter(Mandatory=$false)]
        [string]  $SudoPassword,

        [parameter(Mandatory=$false)]
        [int]     $Concurrency,

        [parameter(Mandatory=$false)]
        [int]     $CompileConcurrency,

        [parameter(Mandatory=$false)]
        [string]  $ModulePath,

        [parameter(Mandatory=$false)]
        [string]  $BoltDir,

        [parameter(Mandatory=$false)]
        [string]  $ConfigFile,

        [parameter(Mandatory=$false)]
        [string]  $InventoryFile,

        [parameter(Mandatory=$false)]
        [bool]    $SaveRerun,

        [parameter(Mandatory=$false)]
        [string]  $Transport,

        [parameter(Mandatory=$false)]
        [int]     $ConnectTimeout,

        [parameter(Mandatory=$false)]
        [bool]    $TTY,

        [parameter(Mandatory=$false)]
        [string]  $Tmpdir,

        # All parameters below are unused by ConvertTo-BoltParameters, but still
        # listed here so other functions can pass @PSBoundParameters.
        [parameter(Mandatory=$false)]
        [string[]]  $TargetCommands,

        [parameter(Mandatory=$false)]
        [string[]]  $PlanNames,

        [parameter(Mandatory=$false)]
        [string[]]  $TaskNames,

        [parameter(Mandatory=$false)]
        [string[]]  $ScriptLocations,

        [parameter(Mandatory=$false)]
        [string[]]  $PuppetManifests,

        [parameter(Mandatory=$false)]
        [string]  $Source,

        [parameter(Mandatory=$false)]
        [string]  $Destination,

        [parameter(Mandatory=$false)]
        [string[]]  $Targets,

        [parameter(Mandatory=$false)]
        [string[]]  $Queries
    )
    process {
        $flags = '--format=json --no-color --verbose'
        # Actually writing debug output will require both the -Debug and -Verbose params for
        # most PS versions
        #
        # When using the -Debug automatic parameter in early versions of powershell,
        # the debug preference is set to 'inquire'. This means that if there were any Write-Debug
        # statements the cmdlet would stop and try to inquire the user if they want to continue.
        #
        # We can't really do this for bolt, since it's running in it's own process. So, unless
        # $DebugPreference is set to 'Continue' (which -Debug will _not_ set on older versions of PS)
        # we will not use Write-Debug but continue to use Write-Verbose and simply add the additional
        # --debug and --trace options to the call to bolt
        if (($DebugPreference -eq 'Inquire') -or ($DebugPreference -eq 'Continue')) {
            $flags += ' --debug --trace'
        }
        if ($Parameters -ne $null) {
            $flags += ' --params ' + "'$($Parameters | ConvertTo-Json -Compress)'"
        }
        if ($Rerun) {
            $flags += " --rerun $($Rerun.ToLower())"
        }
        if ($Noop) {
            $flags += " --noop"
        }
        if ($Description) {
            $flags += " --description $Description"
        }
        if ($SSL) {
            $flags += ' --ssl'
        } else {
            $flags += ' --no-ssl'
        }
        if ($SSLVerify) {
            $flags += ' --ssl-verify'
        } else {
            $flags += ' --no-ssl-verify'
        }
        if ($HostKeyCheck) {
            $flags += ' --host-key-check'
        } else {
            $flags += ' --no-host-key-check'
        }
        if ($Username) {
            $flags += " --user $Username"
        }
        if ($Password) {
            $flags += " --password $Password"
        }
        if ($SSHPrivateKey) {
            $flags += " --private-key $SSHPrivateKey"
        }
        if ($RunAs) {
            $flags += " --run-as $RunAs"
        }
        if ($SudoPassword) {
            $flags += " --sudo-password $SudoPassword"
        }
        if ($Concurrency) {
            $flags += " --concurrency $Concurrency"
        }
        if ($CompileConcurrency) {
            $flags += " --compile-concurrency $CompileConcurrency"
        }
        if ($ModulePath) {
            $flags += " --modulepath $ModulePath"
        }
        if ($BoltDir) {
            $flags += " --boltdir $BoltDir"
        }
        if ($ConfigFile) {
            $flags += " --configfile $ConfigFile"
        }
        if ($InventoryFile) {
            $flags += " --inventoryfile $InventoryFile"
        }
        if ($SaveRerun) {
            $flags += ' --save-rerun'
        } else {
            $flags += ' --no-save-rerun'
        }
        if ($Transport) {
            $flags += " --transport $Transport"
        }
        if ($ConnectTimeout) {
            $flags += " --connect-timeout $ConnectTimeout"
        }
        if ($TTY) {
            $flags += ' --tty'
        } else {
            $flags += ' --no-tty'
        }
        if ($Tmpdir) {
            $flags += " --tmpdir $Tmpdir"
        }
        Write-Output $flags
    }
}

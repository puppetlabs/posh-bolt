function Merge-BoltOutputModulePath {
    <#
    .SYNOPSIS
    This is an internal-only function used to force the modulepath
    output from bolt to a single string. We need to treat modulepath
    differently than other parameters because it _must_ be a single
    string so when bolt attempts to execute it loads all paths in
    modulepath at once rather than one at a time.

    If we do not scrub modulepath like this we would need to allow
    modulepath to be an array in the commandlets, which can create
    unintended consequences when pipelining bolt commands together
    since the commandlet would attempt to run once for each modulepath,
    instead of only once with all modulepaths included.
    #>
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   Position=0)]
        [AllowNull()]
        [AllowEmptyString()]
        [object] $BoltOutput
    )
    process {
        if ($BoltOutput.modulepath) {
            $BoltOutput.modulepath = $BoltOutput.modulepath -join ';'
        }
        Write-Output $BoltOutput
    }
}

function Invoke-BoltInternal {
    <#
    .SYNOPSIS
    This is an internal-only function used to create the bolt process and redirect standard
    error to the verbose stream and stdout to the output stream. Bolt uses stderr to print
    logging messages, so we need to redirect that to verbose so the -Verbose switch will
    work correctly with each cmdlet
    #>
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$true,
                   Position=0)]
        [string] $BoltCommandLine
    )
    process {
        $startInfo = New-Object System.Diagnostics.ProcessStartInfo("$env:RUBY_DIR\bin\ruby.exe", "-S -- $env:RUBY_DIR\bin\bolt $BoltCommandLine")
        $startInfo.UseShellExecute = $false
        $startInfo.CreateNoWindow = $true
        $startInfo.WorkingDirectory = Get-Location
        $startInfo.RedirectStandardError = $true
        $startInfo.RedirectStandardOutput = $true
        $bolt_process = New-Object System.Diagnostics.Process
        $bolt_process.StartInfo = $startInfo
        $bolt_process.Start() | Out-Null
        # StdOut _must_ be read async or there could be deadlocks with
        # the child process while reading both StdOut and StdErr reading
        # synchronously. See "Remarks" here:
        # https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.process.standardoutput?view=netframework-4.8#remarks
        $stdout_async = $bolt_process.StandardOutput.ReadToEndAsync()
        while (!$bolt_process.HasExited) {
            if ($line = $bolt_process.StandardError.ReadLine()) {
                # Honor a value of 'Continue' for writing to debug, but nothing
                # else. If we honored 'Inquire' the cmdlet would stop and ask
                # the user to continue every time a line was read.
                if ($DebugPreference -eq 'Continue') {
                    $line | Write-Debug
                } else {
                    $line | Write-Verbose
                }
            }
        }
        $bolt_process.WaitForExit()
        $result = $stdout_async.Result
        if ($bolt_process.ExitCode -eq 0){
            $result | ConvertFrom-Json | Merge-BoltOutputModulePath | Write-Output
        } else {
            $err = ($result | ConvertFrom-Json)
            if ($err.result_error.msg) {
                $err = $err.result._error.msg
            } elseif ($err._error.msg) {
                $err = $err._error.msg
            } elseif ($err.msg) {
                $err = $err.msg
            } else {
                $err = "Bolt execution failed! re run with -Debug to see more details"
            }
            # Write the whole result to the error stream if DebugPreference is set
            if (($DebugPreference -eq 'Inquire') -or ($DebugPreference -eq 'Continue')) {
                $result | Write-Error
            }
            # intended to be caught by calling functions
            throw $err
        }
    }
}

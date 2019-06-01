# posh-bolt

PowerShell helper commands for interacting with Puppet Bolt

## Developing

### First Time Building The Module

1. Clone the source code
2. Run the `StageFiles` task with `-bootstrap` Option
    - `.\build.ps1 -Task StageFiles -bootstrap`
    - Note that stagefiles is used instead of Build because there currently seems
    to be a bug with building the help files that fails the build.
    - The `-bootstrap` switch will install the required modules onto your machine.
3. Import the built module
    - `Import-Module .\output\posh-bolt -force`
4. Make changes to source files in .\posh-bolt\[public, private, classes] directories.
    - If you have added a new cmdlet don't forget to add it to the list of exported functions in the psd1 file.
5. Rebuild the module
    - `.\build.ps1 -Task StageFiles`
6. Re-Import the modified module
    - `Import-Module .\output\posh-bolt -force`

### Debugging

1. Create a debugentry.ps1 file.
    - Create this file locally but do not commit it to the repository
2. Set a breakpoint
    - Remember to set the breakpoint in the built psm1 file in the output directory. Not the source file in the public/private directories.
    - If the change you made results in changes to the line numbering you may need to build the file again manually first, so the lines of code you want to break on are in their correct position when you set the breakpoint.
3. In the debug entry I usually start the file with the commands needed to build the module and re-import it
    - `.\build.ps1 -Task StageFiles; Import-Module .\output\posh-bolt -force`
4. Enter the command that exercise the code path with your breakpoint.
    - `New-BoltMetadata -scriptFile .\testscript.ps1`
5. Press `f5` to start debugging on the debugentry.ps1 file. When code execution reaches your breakpoint in .\output\posh-bolt.psm1, the debugger will pause execution for you.

## Overview

## Installation

## Examples

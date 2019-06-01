---
external help file: posh-bolt-help.xml
Module Name: posh-bolt
online version: https://puppet.com/products/bolt
schema: 2.0.0
---

# Invoke-BoltPlan

## SYNOPSIS
Execute Puppet Bolt task plan

## SYNTAX

### Target
```
Invoke-BoltPlan [-PlanNames] <String[]> -Targets <String[]> [-Parameters <Object>] [-Rerun <BoltRerunTypes>]
 [-Noop] [-Description <String>] [-SSL <Boolean>] [-SSLVerify <Boolean>] [-HostKeyCheck <Boolean>]
 [-Username <String>] [-Password <String>] [-SSHPrivateKey <String>] [-RunAs <String>] [-SudoPassword <String>]
 [-Concurrency <Int32>] [-CompileConcurrency <Int32>] [-ModulePath <String>] [-BoltDir <String>]
 [-ConfigFile <String>] [-InventoryFile <String>] [-SaveRerun <Boolean>] [-Transport <String>]
 [-ConnectTimeout <Int32>] [-TTY <Boolean>] [-Tmpdir <String>] [<CommonParameters>]
```

### Query
```
Invoke-BoltPlan [-PlanNames] <String[]> -Queries <String[]> [-Parameters <Object>] [-Rerun <BoltRerunTypes>]
 [-Noop] [-Description <String>] [-SSL <Boolean>] [-SSLVerify <Boolean>] [-HostKeyCheck <Boolean>]
 [-Username <String>] [-Password <String>] [-SSHPrivateKey <String>] [-RunAs <String>] [-SudoPassword <String>]
 [-Concurrency <Int32>] [-CompileConcurrency <Int32>] [-ModulePath <String>] [-BoltDir <String>]
 [-ConfigFile <String>] [-InventoryFile <String>] [-SaveRerun <Boolean>] [-Transport <String>]
 [-ConnectTimeout <Int32>] [-TTY <Boolean>] [-Tmpdir <String>] [<CommonParameters>]
```

## DESCRIPTION
This function will execute bolt plans on the targets specified by the -Targets
or -Queries parameter.
Puppet Bolt is an agentless automation solution for running ad-hoc
tasks and operations on remote targets

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -PlanNames
The names of the bolt plans to execute

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Targets
Identifies the targets to execute on.

Enter a string with a comma-separated list of node URIs or group names to have bolt
execute on multiple targets at once

Example: -Targets "localhost,node_group,ssh://nix.com:23,winrm://windows.puppet.com"
* URI format is \[protocol://\]host\[:port\]
* SSH is the default protocol; may be ssh, winrm, pcp, local, docker, remote
* For Windows nodes, specify the winrm:// protocol if it has not be configured
* For SSH, port defaults to \`22\`
* For WinRM, port defaults to \`5985\` or \`5986\` based on the --\[no-\]ssl setting

```yaml
Type: String[]
Parameter Sets: Target
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Queries
PuppetDB Queries to determine the targets

```yaml
Type: String[]
Parameter Sets: Query
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Parameters
Parameters to a task or plan as:
* a valid json string
* powershell HashTable
* a json file: '@\<file\>'

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Rerun
Retry on nodes from the last run
* 'all' all nodes that were part of the last run.
* 'failure' nodes that failed in the last run.
* 'success' nodes that succeeded in the last run.

```yaml
Type: BoltRerunTypes
Parameter Sets: (All)
Aliases:
Accepted values: All, Failure, Success

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Noop
Execute a task that supports it in noop mode

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Description
Description to use for the job

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SSL
Use SSL with WinRM

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SSLVerify
Verify remote host SSL certificate with WinRM

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -HostKeyCheck
Check host keys with SSH

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Username
User to authenticate as

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Password
Password to authenticate with.
Omit the value to prompt for the password.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SSHPrivateKey
Private ssh key to authenticate with

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RunAs
User to run as using privilege escalation

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SudoPassword
Password for privilege escalation.
Omit the value to prompt for the password.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Concurrency
Maximum number of simultaneous connections (default: 100)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CompileConcurrency
Maximum number of simultaneous manifest block compiles (default: number of cores)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ModulePath
List of directories containing modules, separated by ';'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BoltDir
Specify what Boltdir to load config from (default: autodiscovered from current working dir)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConfigFile
Specify where to load config from (default: ~/.puppetlabs/bolt/bolt.yaml)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InventoryFile
Specify where to load inventory from (default: ~/.puppetlabs/bolt/inventory.yaml)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SaveRerun
Whether to update the rerun file after this command.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Transport
Specify a default transport: ssh, winrm, pcp, local, docker, remote

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConnectTimeout
Connection timeout (defaults vary)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TTY
Request a pseudo TTY on targets that support it

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tmpdir
The directory to upload and execute temporary files on the target

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://puppet.com/products/bolt](https://puppet.com/products/bolt)

[https://puppet.com/docs/bolt/latest/writing_tasks_and_plans.html](https://puppet.com/docs/bolt/latest/writing_tasks_and_plans.html)

[https://puppet.com/docs/bolt/latest/bolt_running_plans.html](https://puppet.com/docs/bolt/latest/bolt_running_plans.html)

[https://puppet.com/docs/bolt/latest/writing_plans.html](https://puppet.com/docs/bolt/latest/writing_plans.html)


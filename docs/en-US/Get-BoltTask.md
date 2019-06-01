---
external help file: posh-bolt-help.xml
Module Name: posh-bolt
online version: https://puppet.com/products/bolt
schema: 2.0.0
---

# Get-BoltTask

## SYNOPSIS
Read tasks available to Puppet Bolt

## SYNTAX

```
Get-BoltTask [[-TaskNames] <String[]>] [-ModulePath <String>] [-BoltDir <String>] [-ConfigFile <String>]
 [<CommonParameters>]
```

## DESCRIPTION
This function will get available bolt tasks or details
on a specific task.
Puppet Bolt is an agentless automation
solution for running ad-hoc tasks and operations on remote targets

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -TaskNames
Names of the bolt tasks to show details on

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: tasks

Required: False
Position: 1
Default value: None
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://puppet.com/products/bolt](https://puppet.com/products/bolt)

[https://puppet.com/docs/bolt/latest/bolt_running_tasks.html](https://puppet.com/docs/bolt/latest/bolt_running_tasks.html)

[https://puppet.com/docs/bolt/latest/bolt_command_reference.html](https://puppet.com/docs/bolt/latest/bolt_command_reference.html)


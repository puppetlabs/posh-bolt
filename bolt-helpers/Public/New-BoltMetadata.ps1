function New-BoltMetadata {
    [CmdletBinding()]
    param (
        # The Path to a PowerShell file to write a metadata file for.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $Path,

        # The names of any parameters that should be marked Sensitive
        [Parameter(Mandatory = $false)]
        [string[]]
        $SensitiveParam,

        # Add PowerShell common parameters to the metadata
        [Parameter(Mandatory = $false)]
        [switch]
        $IncludeCommonParameters
    )

    begin {
        $commonParameters = @(
            'ErrorAction'
            'InformationAction'
            'Verbose'
            'WarningAction'
        )

        $paramsToRemove = @(
            'Debug'
            'ErrorVariable'
            'InformationVariable'
            'OutVariable'
            'OutBuffer'
            'PipelineVariable'
            'WarningVariable'
        )
    }

    process {
        foreach ($file in $path) {
            $help = Get-help $file
            $command = Get-Command -Name $file
            $attributesCollection = [System.Collections.Generic.List[object]]::new()
            $outputFileName = [system.io.path]::ChangeExtension((Get-Item $file).fullname, 'json')

            # Get Parameter Data Object
            foreach ($param in $command.Parameters.Values) {
                $description = ($help.parameters.parameter.where( {$_.name -eq $param.name})).description
                @{
                    name              = $param.name
                    type              = $param.ParameterType.Name.Replace('[]', '')
                    isArray           = $param.ParameterType.IsArray
                    isOptional        = !$param.Attributes.Mandatory
                    isCommonParameter = $commonParameters -contains $param.name
                    shouldBeRemoved   = $paramsToRemove -contains $param.name
                    description       = $description
                } `
                    | Where-object shouldBeRemoved -ne $true `
                    | Foreach-Object -Process {$_.type = $_.type.Replace('ActionPreference', 'String'); $_} `
                    | Foreach-object -Process {[void]$attributesCollection.Add($_)}
            }

            # Set Type String
            foreach ($set in $attributesCollection) {
                $typeString = ''

                $typeString = switch -wildcard ($set.type) {
                    'Int*' { 'Integer' }
                    {@('SwitchParameter', 'Bool') -contains $_} { 'Boolean' }
                    Default { 'String' }
                }

                if ($set.isArray) {
                    $typeString = "Varient[Array[{0}], {0}]" -f $typeString
                }

                if ($set.isOptional) {
                    $typeString = "Optional[$typeString]"
                }

                $set.typeString = $typeString
            }

            # If the script supports noop, that goes somewhere else in the json, not as a parameter.
            $_noop = $attributesCollection.where( {$_.name -eq '_noop'})

            if ($_noop) {
                $attributesCollection = $attributesCollection | Where-Object -FilterScript {'_noop' -ne $_.name}
            }

            # Common paremeters are included by default. We remove them though unless the user specificially wants them in the output json.
            if (!$IncludeCommonParameters) {
                $attributesCollection = $attributesCollection | Where-Object -FilterScript {$commonParameters -notcontains $_.name}
            }

            # Build out the parameter objects
            $parameters = @{}

            foreach ($param in $attributesCollection) {
                $parameters.$($param.name) = @{
                    description = $param.description
                    type        = $param.typeString
                }
            }

            $metaObject = @{
                puppet_task_version = 1
                input_method        = 'powershell'
                description         = $help.Synopsis
                parameters          = $parameters
                supports_noop       = ($_noop.count -gt 0)
            }

            $outputContent = $metaObject | ConvertTo-JSON -Depth 99
            Set-Content -Path $outputFileName -Value $outputContent -Encoding utf8
        }
    }

    end {
    }
}

function Get-BoltModulePath {
    [CmdletBinding()]
    param (
    )

    begin {
        $defaultBoltYamlPath = '~/.puppetlabs/bolt/bolt.yaml'
    }

    process {
        try{
            $boltYaml = Get-Content $defaultBoltYamlPath

            if($boltYaml){
                $boltdir = [regex]::match($boltYaml,'^modulepath: \"([^\"]+)\"').Groups[1].value
                foreach($path in $boltdir.split(':')){
                    "`"$path`""
                }
            }

        } catch {
            Write-Error "Cannot find bolt.yaml $defaultBoltYamlPath"
        }
    }

    end {
    }
}

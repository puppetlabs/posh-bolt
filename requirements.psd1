@{
    PSDependOptions = @{
        Target = 'CurrentUser'
    }
    'psake' = @{
        Version = '4.8.0'
    }
    'BuildHelpers' = @{
        Version = '2.0.0'
    }
    'PowerShellBuild' = @{
        Version = '0.3.0'
    }
    # Installing Pester on Many PowerShell 5.1 machines requires using both
    # -SkipPublisherCheck and -Force. PSDepends does not seem to support this
    # in the builtin module dependency type. So we use a command type instead.
    # https://github.com/pester/Pester/issues/999
    'Pester' = @{
        DependencyType = 'Command'
        Source = 'Install-Module -Name Pester -MinimumVersion 4.4.1 -SkipPublisherCheck -Force'
    }
}

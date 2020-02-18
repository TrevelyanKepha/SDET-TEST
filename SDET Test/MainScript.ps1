#Paths
$WorkingDirectory = split-path -parent $MyInvocation.MyCommand.Definition
$ModulesLocationPath = "$WorkingDirectory\Modules"
$InstallationfileLocation = "C:\Users\user\Downloads\Programs\Sublime Text Build 3176 x64 Setup.exe"
#

function RegisterModules {
    <#
    .Description

    Registers all modules created and placed in scripts within the modules folder
    #>
    if (Test-Path $ModulesLocationPath) {
        foreach ($item in (Get-ChildItem -Path $ModulesLocationPath)) {
            Import-Module "$ModulesLocationPath\$item"
        }
    }
    else {
        Write-Information "Path $ModulesLocationPath does not exist"
    }
}

function Main {
    <#
    .Description
    This is the point of entry for program execution.
    It is from this point that installation of the text editor will be initiated

    #>
    RegisterModules
    Install-TextEditor $InstallationfileLocation
}
Main
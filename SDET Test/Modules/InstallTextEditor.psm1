function Install-TextEditor {
    <#
    .Description
    This is a cmdlet that installs a text editor
    #>
    process {
        $Check = Test-Path $InstallationfileLocation
        $retryInstallCount = 0
        $output = $false
        try {
            if ($retryInstallCount -eq 0) -AND ($Check) {
                # If it installs successfully on the first instance
                Write-Information "========================================================="
                Write-Information "Installing Text Editor"
                Write-Information "========================================================="
                Write-Information "Installation beginning..."
                Write-Information ""
                Start-Process -FilePath $SetupFileLocation -ArgumentList '/S' -Verb runas -Wait
                Write-Information "Installation completed."
                Write-Information ""
                $output = $true
                $retryInstallCount += 0
            }
            elseif ($retryInstallCount -gt 0 -AND -lt 11) -AND ($Check) {
                Write-Information "========================================================="
                Write-Information "Installing Text Editor"
                Write-Information "========================================================="
                #1. retry installation if failed
                #2. check if installation was successful
                #3. validate the setup file passed is valid
                Write-Information "Installation beginning..."
                Write-Information ""
                Start-Process -FilePath $SetupFileLocation -ArgumentList '/S' -Verb runas -Wait
                Write-Information "Installation completed."
                Write-Information ""
                if ($output = $true){
                $retryInstallCount += 0
                else ($output = $false)
                $retryInstallCount += 1
                }  
            }
           else ($retryInstallCount -gt 10) -OR ($Check) {
                # if it fails after 10 attempts
                Write-Information "========================================================="
                Write-Information "Installing Text Editor"
                Write-Information "========================================================="
                Write-Information "Installation beginning..."
                Write-Information ""
                Start-Process -FilePath $SetupFileLocation -ArgumentList '/S' -Verb runas -Wait -ErrorAction Stop
                Write-Information "Installation failed."
                Write-Information ""
                $output = $false
            }
        }
        catch {
            $output = $false
            Write-Error "Notepadpluspus installation failed. Retry installation. $PSItem"
            Write-Information "Installation failed."
            Install-TextEditor $InstallationfileLocation
        }
        return $output
    }
}
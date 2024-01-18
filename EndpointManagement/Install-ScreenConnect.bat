@echo off
PowerShell -ExecutionPolicy Bypass -Command "& {
    <# PowerShell Script Starts Here #>

    ## Check for previous ScreenConnect installation & remove if found

    # Replace 'ScreenConnect' with the exact name of the application you want to uninstall
    $appName = '*ScreenConnect*'

    # Obtain the MSI product code for the application
    $product = Get-WmiObject Win32_Product | Where-Object { $_.Name -like $appName }

    # Proceed if the product was found
    if ($product -ne $null) {
        # Uninstall the application silently
        Start-Process 'C:\Windows\System32\msiexec.exe' -ArgumentList '/x $($product.IdentifyingNumber) /quiet' -Wait

        Write-Host 'Uninstallation of ''$appName'' successful.'
    } else {
        Write-Host 'Application ''$appName'' not found. Proceeding with fresh Install.'
    }

    # Define the URL and the destination path
    $url = 'https://help.speedeedelivery.com/Bin/ScreenConnect.ClientSetup.msi?e=Access&y=Guest&c=Spee-Dee%20Delivery&c=Saint%20Cloud&c=General&c=Workstation&c=&c=&c=&c='
    $destination = 'C:\Temp\SDIT\SCAgent.msi'

    # Create the destination directory if it doesn't exist
    if (-not (Test-Path -Path 'C:\Temp\SDIT')) {
        New-Item -ItemType Directory -Force -Path 'C:\Temp\SDIT'
    }

    # Download the file
    Invoke-WebRequest -Uri $url -OutFile $destination

    # Silently install the MSI
    Start-Process 'msiexec.exe' -ArgumentList '/i `'$destination`' /qn' -Wait -NoNewWindow

    <# PowerShell Script Ends Here #>
}"

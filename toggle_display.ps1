# Import the DisplayConfig module
Import-Module DisplayConfig

# Get current display information
$displays = Get-DisplayInfo

# Identify DisplayId 2 (DisplayPort) and DisplayId 3 (HDMI)
$displayPort = $displays | Where-Object { $_.DisplayId -eq 2 }
$hdmi = $displays | Where-Object { $_.DisplayId -eq 3 }

# Check if DisplayPort is active and HDMI is inactive, or vice versa
if ($displayPort.Active -and -not $hdmi.Active) {
    Write-Host "DisplayPort (DisplayId 2) is active. Switching to HDMI (DisplayId 3)..."

    # Enable HDMI (DisplayId 3)
    Enable-Display -DisplayId 3

    # Set HDMI (DisplayId 3) as primary
    Set-DisplayPrimary -DisplayId 3

    # Disable DisplayPort (DisplayId 2)
    Disable-Display -DisplayId 2

} elseif ($hdmi.Active -and -not $displayPort.Active) {
    Write-Host "HDMI (DisplayId 3) is active. Switching to DisplayPort (DisplayId 2)..."

    # Enable DisplayPort (DisplayId 2)
    Enable-Display -DisplayId 2

    # Set DisplayPort (DisplayId 2) as primary
    Set-DisplayPrimary -DisplayId 2

    # Set DisplayPort (DisplayId 2) to 240 Hz
    Set-DisplayRefreshRate -DisplayId 2 -RefreshRate 239.97

    # Disable HDMI (DisplayId 3)
    Disable-Display -DisplayId 3

} else {
    Write-Host "Unexpected display state. DisplayPort (DisplayId 2) and HDMI (DisplayId 3) are either both active or both inactive."
}
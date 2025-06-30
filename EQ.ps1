$file = 'C:\Program Files\EqualizerAPO\config\config.txt'
$shortcut1 = 'C:\Program Files\EqualizerAPO\config\HeSuVi\profile\Buds FE Binaural.lnk'
$shortcut2 = 'C:\Program Files\EqualizerAPO\config\HeSuVi\profile\Buds FE Stereo.lnk'
$shortcut3 = 'C:\Program Files\EqualizerAPO\config\HeSuVi\profile\Warzone.lnk'

# Display options to the user
Write-Host "1. Buds FE Binaural"
Write-Host "2. Buds FE Stereo"
Write-Host "3. Warzone"
Write-Host "4. None"

# Get user input (accepts a number, and escape key exits the script)
do {
    Write-Host "Enter a valid number (1-4 or Esc to exit): "
    $option = [console]::readkey($true).keychar
    # Check if Escape key was pressed
    if ($option -eq [System.ConsoleKey]::Escape) {
        Write-Host "Exiting."
        exit
    }
} while ($option -notin "1", "2", "3", "4")

$content = Get-Content $file

# Modify specific lines based on user option
switch ($option) {
   '1' {
        # Buds FE Binaural
        $content[-5] = "Preamp: -25.8 dB"
        $content[-4] = "Include: HeSuVi\hesuvi.txt"
	$content[-3] = "# Include: peace.txt"
        $content[-2] = "# Include: PreCompressor.txt"
        $content[-1] = "Include: DynamiQ-master\DynamiQ.txt"
    }
   '2' {
        # Buds FE Stereo
        $content[-5] = "Preamp: -10.7 dB"
	$content[-4] = "Include: HeSuVi\hesuvi.txt"
        $content[-3] = "# Include: peace.txt"
        $content[-2] = "# Include: PreCompressor.txt"
        $content[-1] = "Include: DynamiQ-master\DynamiQ.txt"
    }
   '3' {
        # Warzone
        $content[-5] = "Preamp: -5.0 dB"
	$content[-4] = "Include: HeSuVi\hesuvi.txt"
        $content[-3] = "Include: peace.txt"
        $content[-2] = "Include: PreCompressor.txt"
        $content[-1] = "Include: DynamiQ-master\DynamiQ.txt"
    }
   '4' {
        # None - Comment out lines
        $content[-5] = "# Preamp: 0 dB"
	$content[-4] = "# Include HeSuVi\hesuvi.txt"
        $content[-3] = "# Include: peace.txt"
        $content[-2] = "# Include: PreCompressor.txt"
        $content[-1] = "# Include: DynamiQ-master\DynamiQ.txt"
    }
    default {
        Write-Host "Invalid option selected."
    }
}

# Open the corresponding shortcut
switch ($option) {
    '1' { Start-Process $shortcut1 }
    '2' { Start-Process $shortcut2 }
    '3' { Start-Process $shortcut3 }
    '4' { }
}

# Write modified content back to $file
$content | Set-Content -Path $file

# Exit the script
exit
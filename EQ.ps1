$file = 'C:\Program Files\EqualizerAPO\config\config.txt'
$shortcut1 = 'C:\Users\E\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\HeSuVi\Buds FE Binaural.lnk'
$shortcut2 = 'C:\Users\E\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\HeSuVi\Buds FE Stereo.lnk'
$shortcut3 = 'C:\Users\E\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\HeSuVi\Buds FE Warzone.lnk'
$shortcut4 = 'C:\Users\E\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\HeSuVi\Warzone.lnk'

# Display options to the user
Write-Host "1. Buds FE Binaural"
Write-Host "2. Buds FE Stereo"
Write-Host "3. Buds FE Warzone"
Write-Host "4. Warzone"
Write-Host "5. None"

# Get user input (accepts a number, and escape key exits the script)
do {
    Write-Host "Enter a valid number (1-5 or Esc to exit): "
    $option = [console]::readkey($true).keychar
    # Check if Escape key was pressed
    if ($option -eq [System.ConsoleKey]::Escape) {
        Write-Host "Exiting."
        exit
    }
} while ($option -notin "1", "2", "3", "4", "5")

$content = Get-Content $file

# Modify specific lines based on user option
switch ($option) {
   '1' {
        # Buds FE Binaural
        $content[-4] = "Preamp: -25.8 dB"
        $content[-3] = "Include: HeSuVi\hesuvi.txt"
        $content[-2] = "# Include: AIW_WZ3_S2v1.txt"
        $content[-1] = "Include: DynamiQ-master\DynamiQ.txt"
    }
   '2' {
        # Buds FE Stereo
        $content[-4] = "Preamp: -10.7 dB"
        $content[-3] = "Include: HeSuVi\hesuvi.txt"
        $content[-2] = "# Include: AIW_WZ3_S2v1.txt"
        $content[-1] = "Include: DynamiQ-master\DynamiQ.txt"
    }
   '3' {
        # Buds FE Warzone
        $content[-4] = "Preamp: -19.5 dB"
        $content[-3] = "Include: HeSuVi\hesuvi.txt"
        $content[-2] = "Include: AIW_WZ3_S2v1.txt"
        $content[-1] = "Include: DynamiQ-master\DynamiQ.txt"
    }
   '4' {
        # Warzone
        $content[-4] = "Preamp: -21.9 dB"
        $content[-3] = "Include: HeSuVi\hesuvi.txt"
        $content[-2] = "Include: AIW_WZ3_S2v1.txt"
        $content[-1] = "Include: DynamiQ-master\DynamiQ.txt"
    }
   '5' {
        # None - Comment out lines
        $content[-4] = "# Preamp: -21.9 dB"
        $content[-3] = "# Include HeSuVi\hesuvi.txt"
        $content[-2] = "# Include: AIW_WZ3_S2v1.txt"
        $content[-1] = "# Include: DynamiQ-master\DynamiQ.txt"
    }
    default {
        Write-Host "Invalid option selected."
        # Handle other cases (e.g., display an error message)
    }
}

# Open the corresponding shortcut
switch ($option) {
    '1' { Start-Process $shortcut1 }
    '2' { Start-Process $shortcut2 }
    '3' { Start-Process $shortcut3 }
    '4' { Start-Process $shortcut4 }
}

# Write modified content back to $file
$content | Set-Content -Path $file

# Exit the script
exit

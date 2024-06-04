$file = 'C:\Program Files\EqualizerAPO\config\config.txt'
$shortcut1 = 'C:\Users\E\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\HeSuVi\Buds FE Binaural.lnk'
$shortcut2 = 'C:\Users\E\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\HeSuVi\Buds FE Stereo.lnk'
$shortcut3 = 'C:\Users\E\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\HeSuVi\Buds FE Warzone.lnk'
$shortcut4 = 'C:\Users\E\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\HeSuVi\Warzone.lnk'

Write-Host "1. Buds FE Binaural"
Write-Host "2. Buds FE Stereo"
Write-Host "3. Buds FE Warzone"
Write-Host "4. Warzone"
Write-Host "5. None"

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

switch ($option) {
    '1' {
        $content[-4] = 'Preamp: -25.8 dB'
        $content[-2] = '# Include: AIW_WZ3_S2v1.txt'
        Start-Process $shortcut1
    }
    '2' {
        $content[-4] = 'Preamp: -10.7 dB'
        $content[-2] = '# Include: AIW_WZ3_S2v1.txt'
        Start-Process $shortcut2
    }
    '3' {
        $content[-4] = 'Preamp: -19.5 dB'
        $content[-2] = 'Include: AIW_WZ3_S2v1.txt'
        Start-Process $shortcut3
    }
    '4' {
        $content[-4] = 'Preamp: -21.9 dB'
        $content[-2] = 'Include: AIW_WZ3_S2v1.txt'
        Start-Process $shortcut4
    }
    '5' {
        # Replace the last four lines
        $content[-4] = '# Preamp: 0 dB'
        $content[-3] = '# Include: HeSuVi\hesuvi.txt'
        $content[-2] = '# Include: AIW_WZ3_S2v1.txt'
        $content[-1] = '# Include: DynamiQ-master\DynamiQ.txt'
    }
}

# Remove '#' from the last line if it exists (except for Option 5)
if ($option -ne '5' -and $content[-1] -match '^#') {
    $content[-1] = $content[-1].TrimStart('#').Trim()
}

# Join the lines into a single string with newline characters between them
$content = $content -join "`r`n"

# Write the string to the file without a trailing newline
$content | Out-File $file -Encoding ascii -NoNewline

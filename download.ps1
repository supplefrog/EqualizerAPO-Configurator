$DIR = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Audio"
if (-Not (Test-Path $DIR)) { Write-Error "$DIR not found"; exit }
@(
  "EQ.ps1",
  "EQ.ps1.lnk"
) | ForEach-Object {
  Invoke-WebRequest "https://raw.githubusercontent.com/supplefrog/EqualizerAPO-Configurator/refs/heads/main/$_" -OutFile (Join-Path $DIR $_)
  "Downloaded $_ to $DIR"
}

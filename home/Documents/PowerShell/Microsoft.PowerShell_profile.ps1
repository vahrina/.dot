fastfetch -c "$HOME\Documents\fastfetch\config.jsonc"

function wsl {
  if ($args.Count -eq 0) {
    $table = (wsl.exe -l -v) -replace "\x00", "" | Where-Object { $_ -match '\S' } | Select-Object -Skip 1
    $cleanNames = (wsl.exe -l -q) -replace "\x00", "" | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }

    Write-Host "     name      state         ver"
    Write-Host " -------------------------------"

    foreach ($line in $table) {
      $trimmedLine = $line.Trim()

      if ($trimmedLine.StartsWith("*")) {
        $displayLine = $trimmedLine.Substring(1).Trim()
        Write-Host " > " -NoNewline; Write-Host "* $displayLine" -ForegroundColor DarkGreen
      } else {
        Write-Host " >   $trimmedLine"
      }
    }

    do {
      $distro = (Read-Host "boot").Trim()

      if ([string]::IsNullOrWhiteSpace($distro)) {
        Write-Error "specify a distro"
        continue
      }

      if ($cleanNames -contains $distro) {
        wsl.exe -d $distro
        break
      } else {
        Write-Error "'$distro' not found"
      }
    } while ($true)
  } else {
    wsl.exe @args
  }
}

function prompt {
  $path = $PWD.path -replace [regex]::Escape($HOME), "~" -replace '\\', '/'
  $parts = $path -split '/' | Where-Object { $_ }
  $dir = ($parts[-2..-1] -join '/')
  "$dir`nλ "
}

Set-PSReadLineKeyHandler -Key Tab -Function Complete

function Convert-JsoncToJson {
    <#
    .SYNOPSIS
        Converts JSONC files to JSON by removing comments.

    .DESCRIPTION
        Processes JSONC (JSON with Comments) files by removing single-line (//) and
        multi-line (/* */) comments, trailing commas, and saves them as valid JSON files.

    .PARAMETER Path
        Path to a JSONC file or directory containing JSONC files.

    .PARAMETER OutputPath
        Optional output directory for JSON files. If not specified, files are saved
        in the same directory with .json extension.

    .PARAMETER Recurse
        Search for .jsonc files recursively in subdirectories.

    .EXAMPLE
        Convert-JsoncToJson -Path ".\policies\definitions" -Recurse
        Processes all .jsonc files recursively in the policies directory.

    .EXAMPLE
        Convert-JsoncToJson -Path ".\naming-convention.jsonc" -OutputPath ".\output"
        Processes a single file and saves to output directory.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Path,

        [Parameter(Mandatory = $false)]
        [string]$OutputPath = "",

        [switch]$Recurse
    )

    function Remove-JsoncComments {
        param([string]$Content)

        # Remove multi-line comments /* ... */
        $Content = $Content -replace '/\*[\s\S]*?\*/', ''

        # Remove single-line comments //
        $lines = $Content -split "`n"
        $cleanedLines = foreach ($line in $lines) {
            $inString = $false
            $cleanedLine = ""

            for ($i = 0; $i -lt $line.Length; $i++) {
                $char = $line[$i]

                if ($char -eq '"' -and ($i -eq 0 -or $line[$i - 1] -ne '\')) {
                    $inString = -not $inString
                }

                if (-not $inString -and $i -lt ($line.Length - 1) -and $line[$i] -eq '/' -and $line[$i + 1] -eq '/') {
                    break
                }

                $cleanedLine += $char
            }
            $cleanedLine
        }

        $Content = $cleanedLines -join "`n"

        # Remove trailing commas
        $Content = $Content -replace ',(\s*[}\]])', '$1'

        return $Content
    }

    try {
        # Get JSONC files
        $Path = Resolve-Path $Path -ErrorAction Stop
        $files = if (Test-Path $Path -PathType Container) {
            Get-ChildItem -Path $Path -Filter "*.jsonc" -File -Recurse:$Recurse
        } else {
            Get-Item $Path
        }

        if (-not $files) {
            Write-Host "`nWARNING: No JSONC files found in: $Path" -ForegroundColor Yellow
            Write-Host "         Skipping conversion step`n" -ForegroundColor Gray
            return
        }

        # Header
        Write-Host ""
        Write-Host "╔════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║               JSONC TO JSON CONVERSION PROCESS                             ║" -ForegroundColor Cyan
        Write-Host "╚════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Source Path: $Path" -ForegroundColor White
        Write-Host "Files Found: $($files.Count) JSONC file(s)" -ForegroundColor White
        Write-Host ""
        Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
        Write-Host ""

        # Process each file
        $successCount = 0
        $failCount = 0
        $currentFile = 0

        foreach ($file in $files) {
            try {
                $currentFile++
                $fileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
                $relativePath = $file.FullName.Replace($Path, "").TrimStart('\', '/')

                Write-Host "[$currentFile/$($files.Count)] " -NoNewline -ForegroundColor DarkCyan
                Write-Host "Converting: " -NoNewline -ForegroundColor Cyan
                Write-Host "$relativePath" -ForegroundColor White

                $jsoncContent = Get-Content -Path $file.FullName -Raw -Encoding UTF8
                $jsonContent = Remove-JsoncComments -Content $jsoncContent

                # Validate JSON
                $isValid = $false
                try {
                    $null = $jsonContent | ConvertFrom-Json -ErrorAction Stop
                    $isValid = $true
                    Write-Host "    [OK] Validated" -ForegroundColor Green -NoNewline
                }
                catch {
                    Write-Host "    [WARN] Validation Warning: $($_.Exception.Message)" -ForegroundColor Yellow
                }

                # Save JSON file
                if ($OutputPath) {
                    if (-not (Test-Path $OutputPath)) {
                        New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
                    }
                    $outputFile = Join-Path $OutputPath "$fileName.json"
                }
                else {
                    $outputFile = Join-Path (Split-Path $file.FullName -Parent) "$fileName.json"
                }

                $jsonContent | Set-Content -Path $outputFile -Encoding UTF8 -NoNewline

                if ($isValid) {
                    Write-Host " | " -NoNewline -ForegroundColor DarkGray
                    Write-Host "Saved" -ForegroundColor Green
                }
                else {
                    Write-Host "    [WARN] Saved (with warnings)" -ForegroundColor Yellow
                }

                $successCount++
            }
            catch {
                $failCount++
                Write-Host "    [ERROR] Failed: $($_.Exception.Message)" -ForegroundColor Red
            }

            # Add spacing between files
            if ($currentFile -lt $files.Count) {
                Write-Host ""
            }
        }

        # Summary
        Write-Host ""
        Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
        Write-Host ""
        Write-Host "CONVERSION SUMMARY" -ForegroundColor Cyan
        Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
        Write-Host "  [OK] Successful: " -NoNewline -ForegroundColor Green
        Write-Host "$successCount / $($files.Count)" -ForegroundColor White

        if ($failCount -gt 0) {
            Write-Host "  [ERROR] Failed: " -NoNewline -ForegroundColor Red
            Write-Host "$failCount / $($files.Count)" -ForegroundColor White
        }

        Write-Host ""

        if ($successCount -eq $files.Count) {
            Write-Host "  All files converted successfully!" -ForegroundColor Green
        }
        elseif ($successCount -gt 0) {
            Write-Host "  [WARN] Some files converted with issues" -ForegroundColor Yellow
        }
        else {
            Write-Host "  [ERROR] Conversion failed" -ForegroundColor Red
        }

        Write-Host ""
        Write-Host "╚════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
        Write-Host ""
    }
    catch {
        Write-Error "An error occurred: $($_.Exception.Message)"
        throw
    }
}

Export-ModuleMember -Function Convert-JsoncToJson

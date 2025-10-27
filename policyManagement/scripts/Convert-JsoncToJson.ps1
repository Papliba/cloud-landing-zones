<#
.SYNOPSIS
    Converts JSONC files to JSON by removing comments.

.PARAMETER Path
    Path to a JSONC file or directory containing JSONC files.

.PARAMETER OutputPath
    Optional output directory for JSON files.

.PARAMETER Recurse
    Search for .jsonc files recursively in subdirectories.

.EXAMPLE
    .\Convert-JsoncToJson.ps1 -Path ".\policies\definitions" -Recurse
#>

param(
    [Parameter(Mandatory = $true)]
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

# Get JSONC files
$Path = Resolve-Path $Path
$files = if (Test-Path $Path -PathType Container) {
    Get-ChildItem -Path $Path -Filter "*.jsonc" -File -Recurse:$Recurse
} else {
    Get-Item $Path
}

if (-not $files) {
    Write-Warning "No .jsonc files found"
    exit 0
}

Write-Host "Found $($files.Count) JSONC file(s)`n" -ForegroundColor Yellow

# Process each file
$successCount = 0
foreach ($file in $files) {
    try {
        Write-Host "Processing: $($file.FullName)" -ForegroundColor Cyan

        $jsoncContent = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        $jsonContent = Remove-JsoncComments -Content $jsoncContent

        # Validate JSON
        try {
            $null = $jsonContent | ConvertFrom-Json -ErrorAction Stop
            Write-Host "  ✓ Valid JSON" -ForegroundColor Green
        }
        catch {
            Write-Warning "  ⚠ JSON validation failed: $($_.Exception.Message)"
        }

        # Save JSON file
        $fileName = [System.IO.Path]::GetFileNameWithoutExtension($file.FullName)
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
        Write-Host "  → Saved to: $outputFile" -ForegroundColor Green

        $successCount++
    }
    catch {
        Write-Error "Failed to process $($file.FullName): $($_.Exception.Message)"
    }
}

Write-Host "`n================================" -ForegroundColor Cyan
Write-Host "Success: $successCount / $($files.Count)" -ForegroundColor Green
Write-Host "================================`n" -ForegroundColor Cyan

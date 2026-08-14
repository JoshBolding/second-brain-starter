param(
    [Parameter(Mandatory = $true)][string]$Query,
    [ValidateSet('Content', 'Files')][string]$Mode = 'Content',
    [Parameter(Mandatory = $true)][string]$Vault,
    [switch]$IncludeArchive,
    [ValidateRange(1, 500)][int]$MaxResults = 100
)

$ErrorActionPreference = 'Stop'
$Vault = (Resolve-Path -LiteralPath $Vault).Path
$excluded = @('99 Sensitive Review', '.obsidian', '_assets')
if (-not $IncludeArchive) { $excluded += '90 Archive' }

$rg = Get-Command rg -ErrorAction SilentlyContinue
if ($rg) {
    $globs = @('--glob', '*.md')
    foreach ($folder in $excluded) { $globs += @('--glob', "!$folder/**") }
    if ($Mode -eq 'Files') {
        $results = & $rg.Source --files @globs $Vault | Where-Object { $_ -match [regex]::Escape($Query) }
    } else {
        $results = & $rg.Source --fixed-strings --ignore-case --line-number --no-heading --color never @globs -- $Query $Vault
    }
} else {
    $files = Get-ChildItem -LiteralPath $Vault -Recurse -File -Filter '*.md' | Where-Object {
        $relative = $_.FullName.Substring($Vault.Length).TrimStart('\')
        -not ($excluded | Where-Object { $relative -like "$_\*" })
    }
    if ($Mode -eq 'Files') {
        $results = $files.FullName | Where-Object { $_ -match [regex]::Escape($Query) }
    } else {
        $results = $files | Select-String -SimpleMatch -CaseSensitive:$false -Pattern $Query | ForEach-Object {
            "$($_.Path):$($_.LineNumber):$($_.Line.Trim())"
        }
    }
}

@($results | Select-Object -First $MaxResults)

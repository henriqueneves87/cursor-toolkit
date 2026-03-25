# cursor-toolkit update-all.ps1
# Atualiza o toolkit em todos os projetos cadastrados.
# Uso: .\update-all.ps1 [-Force] [-DryRun]
param(
    [switch]$Force,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$installer = Join-Path $PSScriptRoot "install.ps1"

# Lista de projetos - adicione novos projetos aqui
$projects = @(
    "C:\Python\hn_erp",
    "C:\Python\saphiro_info",
    "C:\Python\site-vertx",
    "C:\Python\speedpay_adm",
    "C:\Python\strattos_erp",
    "C:\clinica saad",
    "C:\clinica saad\erp-consultorio-python",
    "C:\postgree_hn",
    "C:\saphiro_baas",
    "C:\spdpay_gateway",
    "C:\speedpay_erp"
)

Write-Host ""
Write-Host "cursor-toolkit - Atualizacao em massa" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
if ($DryRun) { Write-Host "  MODO DRY-RUN - nenhuma alteracao sera feita" -ForegroundColor Yellow }
Write-Host ""

$results = @()

foreach ($p in $projects) {
    $exists = Test-Path $p
    $hasCursor = Test-Path (Join-Path $p ".cursor")

    if (-not $exists) {
        Write-Host "  SKIP  $p  (caminho nao encontrado)" -ForegroundColor Gray
        $results += [PSCustomObject]@{ Projeto = $p; Status = "SKIP (nao existe)" }
        continue
    }

    if (-not $hasCursor) {
        Write-Host "  NOVO  $p  (instalando pela primeira vez)" -ForegroundColor Yellow
    } else {
        Write-Host "  UPD   $p" -ForegroundColor White
    }

    if (-not $DryRun) {
        & $installer -ProjectPath $p -Force | Out-Null
        $results += [PSCustomObject]@{ Projeto = $p; Status = "OK" }
    } else {
        $results += [PSCustomObject]@{ Projeto = $p; Status = "DRY-RUN" }
    }
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host "  Concluido!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""
$results | Format-Table -AutoSize
Write-Host ""
Write-Host "Para atualizar o toolkit antes de rodar:" -ForegroundColor Gray
Write-Host "  cd C:\Python\cursor-toolkit" -ForegroundColor Gray
Write-Host "  git pull" -ForegroundColor Gray
Write-Host "  .\update-all.ps1" -ForegroundColor Gray

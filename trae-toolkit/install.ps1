# trae-toolkit install.ps1
# Instala project_rules.md no diretorio .trae/ do projeto alvo

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$toolkitDir = $PSScriptRoot
$sourceFile = "$toolkitDir\project_rules.md"
$traeDir = "$ProjectPath\.trae"
$destFile = "$traeDir\project_rules.md"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  trae-toolkit - Instalacao" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Projeto:  $ProjectPath"
Write-Host "Destino:  $destFile"
Write-Host ""

# Validar projeto alvo
if (-not (Test-Path $ProjectPath)) {
    Write-Host "ERRO: Diretorio do projeto nao encontrado: $ProjectPath" -ForegroundColor Red
    exit 1
}

# Validar arquivo fonte
if (-not (Test-Path $sourceFile)) {
    Write-Host "ERRO: project_rules.md nao encontrado em: $sourceFile" -ForegroundColor Red
    exit 1
}

# Criar .trae/ se nao existir
if (-not (Test-Path $traeDir)) {
    New-Item -ItemType Directory -Path $traeDir -Force | Out-Null
    Write-Host "Criado: .trae/" -ForegroundColor Green
}

# Verificar se ja existe
if (Test-Path $destFile) {
    if ($Force) {
        $backup = "$destFile.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Copy-Item $destFile $backup
        Write-Host "Backup criado: $backup" -ForegroundColor Yellow
        Copy-Item $sourceFile $destFile -Force
        Write-Host "project_rules.md atualizado" -ForegroundColor Green
    } else {
        Write-Host "project_rules.md ja existe em .trae/" -ForegroundColor Yellow
        Write-Host "Use -Force para sobrescrever (backup automatico sera criado)." -ForegroundColor Yellow
        exit 0
    }
} else {
    Copy-Item $sourceFile $destFile -Force
    Write-Host "project_rules.md instalado" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Instalacao concluida!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Instalado em: $destFile" -ForegroundColor White
Write-Host ""
Write-Host "O Trae IDE carregara as regras automaticamente." -ForegroundColor Cyan
Write-Host ""
Write-Host "Para atualizar: .\install.ps1 -ProjectPath `"$ProjectPath`" -Force" -ForegroundColor Gray
Write-Host ""

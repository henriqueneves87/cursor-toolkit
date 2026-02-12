# install-workflows.ps1
# Helper para instalar workflows do windsurf-toolkit em um projeto especifico

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$toolkitDir = $PSScriptRoot
$workflowsSource = "$toolkitDir\workflows"
$workflowsDest = "$ProjectPath\.windsurf\workflows"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Instalar Workflows no Projeto" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Projeto:   $ProjectPath"
Write-Host "Workflows: $workflowsSource"
Write-Host ""

# Verificar se o projeto existe
if (-not (Test-Path $ProjectPath)) {
    Write-Host "ERRO: Projeto nao encontrado: $ProjectPath" -ForegroundColor Red
    exit 1
}

# Verificar se workflows source existe
if (-not (Test-Path $workflowsSource)) {
    Write-Host "ERRO: Pasta workflows nao encontrada: $workflowsSource" -ForegroundColor Red
    exit 1
}

# Criar diretorio .windsurf se nao existir
$windsurfDir = "$ProjectPath\.windsurf"
if (-not (Test-Path $windsurfDir)) {
    New-Item -ItemType Directory -Path $windsurfDir -Force | Out-Null
    Write-Host "Criado: .windsurf\" -ForegroundColor Green
}

# Verificar se workflows ja existe
if (Test-Path $workflowsDest) {
    if ($Force) {
        $backup = "$workflowsDest`_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Move-Item $workflowsDest $backup
        Write-Host "Backup criado: $backup" -ForegroundColor Yellow
    } else {
        Write-Host "AVISO: .windsurf\workflows ja existe no projeto" -ForegroundColor Yellow
        Write-Host "Use -Force para sobrescrever (criara backup)" -ForegroundColor Yellow
        exit 1
    }
}

# Copiar workflows
Copy-Item $workflowsSource $workflowsDest -Recurse -Force
$count = (Get-ChildItem $workflowsDest -File).Count

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Workflows instalados!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "$count workflows copiados para:" -ForegroundColor White
Write-Host "  $workflowsDest" -ForegroundColor White
Write-Host ""
Write-Host "Use no Cascade com: /nome-do-workflow" -ForegroundColor Cyan
Write-Host ""
Write-Host "Exemplos:" -ForegroundColor Gray
Write-Host "  /context-boot" -ForegroundColor Gray
Write-Host "  /apply-conventions" -ForegroundColor Gray
Write-Host "  /create-execution-plan" -ForegroundColor Gray
Write-Host ""

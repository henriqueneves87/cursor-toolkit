# windsurf-toolkit install.ps1
# Instala windsurf-toolkit na estrutura correta do Windsurf

param(
    [switch]$Force,
    [switch]$Uninstall
)

$ErrorActionPreference = "Stop"
$toolkitDir = $PSScriptRoot
$windsurfSkillsDir = "$env:USERPROFILE\.codeium\windsurf\skills"
$windsurfMemoriesDir = "$env:USERPROFILE\.codeium\windsurf\memories"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  windsurf-toolkit - Instalacao" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Toolkit:  $toolkitDir"
Write-Host "Skills:   $windsurfSkillsDir"
Write-Host "Rules:    $windsurfMemoriesDir\global_rules.md"
Write-Host ""

# Verificar se diretorios existem
if (-not (Test-Path $windsurfSkillsDir)) {
    New-Item -ItemType Directory -Path $windsurfSkillsDir -Force | Out-Null
}
if (-not (Test-Path $windsurfMemoriesDir)) {
    Write-Host "ERRO: Diretorio memories nao encontrado: $windsurfMemoriesDir" -ForegroundColor Red
    Write-Host "Verifique se o Windsurf esta instalado e foi executado pelo menos uma vez." -ForegroundColor Red
    exit 1
}

# --- UNINSTALL ---
if ($Uninstall) {
    Write-Host "Removendo instalacao..." -ForegroundColor Yellow
    
    # Remover skills
    if (Test-Path $windsurfSkillsDir) {
        Get-ChildItem $windsurfSkillsDir -Directory | ForEach-Object {
            Remove-Item $_.FullName -Recurse -Force
            Write-Host "  Removido: $($_.Name)" -ForegroundColor Green
        }
    }
    
    # Backup global_rules.md antes de remover
    $globalRulesPath = "$windsurfMemoriesDir\global_rules.md"
    if (Test-Path $globalRulesPath) {
        $backup = "$globalRulesPath.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Copy-Item $globalRulesPath $backup
        Write-Host "  Backup de global_rules.md criado: $backup" -ForegroundColor Yellow
        Write-Host "  AVISO: global_rules.md nao foi removido (pode conter suas rules)" -ForegroundColor Yellow
    }
    
    Write-Host ""
    Write-Host "Desinstalacao concluida." -ForegroundColor Green
    exit 0
}

# --- INSTALL ---

# 1. Instalar Skills
Write-Host "Instalando skills..." -ForegroundColor White
$skillsInstalled = 0
Get-ChildItem "$toolkitDir\skills" -Directory | ForEach-Object {
    $destPath = "$windsurfSkillsDir\$($_.Name)"
    if (Test-Path $destPath) {
        if ($Force) {
            Remove-Item $destPath -Recurse -Force
            Copy-Item $_.FullName $destPath -Recurse -Force
            Write-Host "  Atualizado: $($_.Name)" -ForegroundColor Yellow
        } else {
            Write-Host "  Ja existe: $($_.Name) (use -Force para atualizar)" -ForegroundColor Gray
        }
    } else {
        Copy-Item $_.FullName $destPath -Recurse -Force
        Write-Host "  Instalado: $($_.Name)" -ForegroundColor Green
        $skillsInstalled++
    }
}

# 2. Instalar Global Rules
Write-Host ""
Write-Host "Instalando global rules..." -ForegroundColor White
$globalRulesPath = "$windsurfMemoriesDir\global_rules.md"
$sourceRules = "$toolkitDir\global_rules.md"

if (Test-Path $globalRulesPath) {
    if ($Force) {
        $backup = "$globalRulesPath.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Copy-Item $globalRulesPath $backup
        Write-Host "  Backup criado: $backup" -ForegroundColor Yellow
        Copy-Item $sourceRules $globalRulesPath -Force
        Write-Host "  global_rules.md atualizado" -ForegroundColor Green
    } else {
        Write-Host "  global_rules.md ja existe (use -Force para sobrescrever)" -ForegroundColor Yellow
        Write-Host "  DICA: Voce pode mesclar manualmente o conteudo de:" -ForegroundColor Cyan
        Write-Host "    $sourceRules" -ForegroundColor Cyan
    }
} else {
    Copy-Item $sourceRules $globalRulesPath -Force
    Write-Host "  global_rules.md instalado" -ForegroundColor Green
}

# 3. Informar sobre Workflows
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Workflows (nivel projeto)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Workflows devem ser copiados manualmente para cada projeto:" -ForegroundColor Yellow
Write-Host "  1. Copie a pasta 'workflows' para .windsurf/workflows/ do seu projeto" -ForegroundColor White
Write-Host "  2. Invoque com /nome-do-workflow no Cascade" -ForegroundColor White
Write-Host ""
Write-Host "Exemplo:" -ForegroundColor Gray
Write-Host "  cp -r $toolkitDir\workflows seu-projeto\.windsurf\" -ForegroundColor Gray
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "  Instalacao concluida!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Instalado:" -ForegroundColor White
Write-Host "  Skills:       $windsurfSkillsDir" -ForegroundColor White
Write-Host "  Global Rules: $globalRulesPath" -ForegroundColor White
Write-Host ""
Write-Host "Reinicie o Windsurf para carregar as novas configuracoes." -ForegroundColor Cyan
Write-Host ""
Write-Host "Opcoes:" -ForegroundColor Gray
Write-Host "  .\install.ps1           - Instalar" -ForegroundColor Gray
Write-Host "  .\install.ps1 -Force    - Reinstalar/Atualizar" -ForegroundColor Gray
Write-Host "  .\install.ps1 -Uninstall - Remover" -ForegroundColor Gray

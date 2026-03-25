# cursor-toolkit install.ps1
# Copia rules, skills, commands e agents para .cursor/ dentro do projeto destino.
# Uso: .\install.ps1 -ProjectPath "C:\caminho\do\projeto" [-Force] [-Uninstall]
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,
    [switch]$Force,
    [switch]$Uninstall
)

$ErrorActionPreference = "Stop"
$toolkitDir = $PSScriptRoot
$cursorDir = Join-Path $ProjectPath ".cursor"

Write-Host ""
Write-Host "cursor-toolkit - Instalacao no projeto" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Toolkit: $toolkitDir"
Write-Host "Projeto: $ProjectPath"
Write-Host "Destino: $cursorDir"
Write-Host ""

if (-not (Test-Path $ProjectPath)) {
    Write-Host "ERRO: Caminho do projeto nao encontrado: $ProjectPath" -ForegroundColor Red
    exit 1
}

$targets = @(
    @{ Name = "skills";   Src = "$toolkitDir\skills";   Dst = "$cursorDir\skills" }
    @{ Name = "commands"; Src = "$toolkitDir\commands";  Dst = "$cursorDir\commands" }
    @{ Name = "agents";   Src = "$toolkitDir\agents";    Dst = "$cursorDir\agents" }
)

# rules: copiar apenas .mdc (exceto project-specific-template.mdc)
$rulesDir = "$toolkitDir\rules"
$rulesDst = "$cursorDir\rules"

# --- UNINSTALL ---
if ($Uninstall) {
    Write-Host "Removendo instalacao do projeto..." -ForegroundColor Yellow
    foreach ($t in $targets) {
        if (Test-Path $t.Dst) {
            Remove-Item -Recurse -Force $t.Dst
            Write-Host "  Removido: $($t.Name)" -ForegroundColor Green
        } else {
            Write-Host "  $($t.Name) - nao encontrado, ignorando" -ForegroundColor Gray
        }
    }
    if (Test-Path $rulesDst) {
        Remove-Item -Recurse -Force $rulesDst
        Write-Host "  Removido: rules" -ForegroundColor Green
    } else {
        Write-Host "  rules - nao encontrado, ignorando" -ForegroundColor Gray
    }
    Write-Host ""
    Write-Host "Desinstalacao concluida." -ForegroundColor Green
    exit 0
}

# --- INSTALL ---
$totalCopied = @{ skills = 0; commands = 0; agents = 0; rules = 0 }

foreach ($t in $targets) {
    Write-Host "Configurando $($t.Name)..." -ForegroundColor White

    if (Test-Path $t.Dst) {
        if ($Force) {
            $backup = "$($t.Dst)_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
            Rename-Item $t.Dst $backup
            Write-Host "  Backup criado: $backup" -ForegroundColor Yellow
        } else {
            Write-Host "  Ja existe. Use -Force para sobrescrever com backup." -ForegroundColor Yellow
            continue
        }
    }

    New-Item -ItemType Directory -Path $t.Dst -Force | Out-Null
    Copy-Item -Path "$($t.Src)\*" -Destination $t.Dst -Recurse -Force

    $count = (Get-ChildItem -Recurse -File $t.Dst).Count
    $totalCopied[$t.Name] = $count
    Write-Host "  Copiado: $($t.Dst) ($count arquivos)" -ForegroundColor Green
}

# --- RULES (.mdc, exceto project-specific-template.mdc) ---
Write-Host "Configurando rules..." -ForegroundColor White

if (Test-Path $rulesDst) {
    if ($Force) {
        $backup = "${rulesDst}_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Rename-Item $rulesDst $backup
        Write-Host "  Backup criado: $backup" -ForegroundColor Yellow
    } else {
        Write-Host "  Ja existe. Use -Force para sobrescrever com backup." -ForegroundColor Yellow
    }
}

if (-not (Test-Path $rulesDst)) {
    New-Item -ItemType Directory -Path $rulesDst -Force | Out-Null
}

$ruleFiles = Get-ChildItem -Path $rulesDir -Filter "*.mdc" |
    Where-Object { $_.Name -ne "project-specific-template.mdc" }

foreach ($f in $ruleFiles) {
    Copy-Item -Path $f.FullName -Destination $rulesDst -Force
}

$totalCopied["rules"] = $ruleFiles.Count
Write-Host "  Copiado: $rulesDst ($($ruleFiles.Count) arquivos)" -ForegroundColor Green

Write-Host ""
Write-Host "=======================================" -ForegroundColor Green
Write-Host "  Instalacao concluida!" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green
Write-Host ""
Write-Host "Resumo de arquivos copiados:" -ForegroundColor Cyan
Write-Host "  rules:    $($totalCopied['rules'])" -ForegroundColor White
Write-Host "  skills:   $($totalCopied['skills'])" -ForegroundColor White
Write-Host "  commands: $($totalCopied['commands'])" -ForegroundColor White
Write-Host "  agents:   $($totalCopied['agents'])" -ForegroundColor White
Write-Host ""
Write-Host "Opcoes disponiveis:" -ForegroundColor Gray
Write-Host "  .\install.ps1 -ProjectPath <caminho>          - Instalar no projeto" -ForegroundColor Gray
Write-Host "  .\install.ps1 -ProjectPath <caminho> -Force   - Reinstalar (backup do existente)" -ForegroundColor Gray
Write-Host "  .\install.ps1 -ProjectPath <caminho> -Uninstall - Remover instalacao" -ForegroundColor Gray
Write-Host ""
Write-Host "Para atualizar: git pull && .\install.ps1 -ProjectPath <caminho> -Force" -ForegroundColor Cyan

# windsurf-toolkit install.ps1
# Cria symlinks/copia do windsurf-toolkit para os diretorios do Windsurf
# Requer: Executar como Administrador (para criar symlinks no Windows)

param(
    [switch]$Force,
    [switch]$Copy,
    [switch]$Uninstall
)

$ErrorActionPreference = "Stop"
$toolkitDir = $PSScriptRoot
$windsurfSkillsDir = "$env:USERPROFILE\.codeium\windsurf\skills"
$windsurfWorkspaceDir = "$env:USERPROFILE\.windsurf"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  windsurf-toolkit - Instalacao" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Toolkit: $toolkitDir"
Write-Host "Skills:  $windsurfSkillsDir"
Write-Host "Rules:   $windsurfWorkspaceDir\rules"
Write-Host ""

# Verificar se o diretorio do Windsurf existe
if (-not (Test-Path $windsurfWorkspaceDir)) {
    Write-Host "ERRO: Diretorio do Windsurf nao encontrado: $windsurfWorkspaceDir" -ForegroundColor Red
    Write-Host "Verifique se o Windsurf esta instalado." -ForegroundColor Red
    exit 1
}

# Criar diretorio de skills se nao existir
if (-not (Test-Path $windsurfSkillsDir)) {
    New-Item -ItemType Directory -Path $windsurfSkillsDir -Force | Out-Null
}

$targets = @(
    @{ Name = "skills";    Src = "$toolkitDir\skills";    Dst = "$windsurfSkillsDir" }
    @{ Name = "workflows"; Src = "$toolkitDir\workflows"; Dst = "$windsurfWorkspaceDir\workflows" }
    @{ Name = "rules";     Src = "$toolkitDir\rules";     Dst = "$windsurfWorkspaceDir\rules" }
)

# --- UNINSTALL ---
if ($Uninstall) {
    Write-Host "Removendo instalacao..." -ForegroundColor Yellow
    foreach ($t in $targets) {
        if (Test-Path $t.Dst) {
            $item = Get-Item $t.Dst -Force
            if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
                $item.Delete()
                Write-Host "  Removido symlink: $($t.Name)" -ForegroundColor Green
            } else {
                Write-Host "  AVISO: $($t.Dst) nao e symlink, nao removido" -ForegroundColor Yellow
            }
        } else {
            Write-Host "  $($t.Name) - nao encontrado, ignorando" -ForegroundColor Gray
        }
    }
    Write-Host ""
    Write-Host "Desinstalacao concluida." -ForegroundColor Green
    exit 0
}

# --- INSTALL ---
foreach ($t in $targets) {
    Write-Host "Configurando $($t.Name)..." -ForegroundColor White

    # Para skills, copiar conteudo dentro do diretorio
    if ($t.Name -eq "skills") {
        if (-not (Test-Path $t.Dst)) {
            New-Item -ItemType Directory -Path $t.Dst -Force | Out-Null
        }
        Write-Host "  Copiando skills para: $($t.Dst)" -ForegroundColor Yellow
        Copy-Item -Path "$($t.Src)\*" -Destination $t.Dst -Recurse -Force
        Write-Host "  Skills copiados com sucesso" -ForegroundColor Green
        continue
    }

    if (Test-Path $t.Dst) {
        $existing = Get-Item $t.Dst -Force
        
        if ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            if ($Force) {
                $existing.Delete()
                Write-Host "  Symlink existente removido (--Force)" -ForegroundColor Yellow
            } else {
                Write-Host "  Symlink ja existe. Use -Force para substituir." -ForegroundColor Yellow
                continue
            }
        } else {
            if ($Force) {
                $backup = "$($t.Dst)_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
                Rename-Item $t.Dst $backup
                Write-Host "  Backup criado: $backup" -ForegroundColor Yellow
            } elseif ($Copy) {
                Write-Host "  Diretorio existe. Copiando arquivos..." -ForegroundColor Yellow
                Copy-Item -Path "$($t.Src)\*" -Destination $t.Dst -Recurse -Force
                Write-Host "  Arquivos copiados para $($t.Dst)" -ForegroundColor Green
                continue
            } else {
                Write-Host "  Diretorio ja existe. Use -Force (backup+symlink) ou -Copy (copiar arquivos)" -ForegroundColor Yellow
                continue
            }
        }
    }

    if ($Copy) {
        New-Item -ItemType Directory -Path $t.Dst -Force | Out-Null
        Copy-Item -Path "$($t.Src)\*" -Destination $t.Dst -Recurse -Force
        Write-Host "  Copiado para: $($t.Dst)" -ForegroundColor Green
    } else {
        try {
            New-Item -ItemType SymbolicLink -Path $t.Dst -Target $t.Src -Force | Out-Null
            Write-Host "  Symlink criado: $($t.Dst) -> $($t.Src)" -ForegroundColor Green
        } catch {
            Write-Host "  ERRO ao criar symlink. Execute como Administrador ou use -Copy" -ForegroundColor Red
            Write-Host "  Fallback: copiando arquivos..." -ForegroundColor Yellow
            New-Item -ItemType Directory -Path $t.Dst -Force | Out-Null
            Copy-Item -Path "$($t.Src)\*" -Destination $t.Dst -Recurse -Force
            Write-Host "  Copiado para: $($t.Dst)" -ForegroundColor Green
        }
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Instalacao concluida!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "IMPORTANTE: Skills instalados em:" -ForegroundColor Cyan
Write-Host "  $windsurfSkillsDir" -ForegroundColor Cyan
Write-Host ""
Write-Host "Opcoes disponiveis:" -ForegroundColor Gray
Write-Host "  .\install.ps1              - Instalar (symlinks, requer Admin)" -ForegroundColor Gray
Write-Host "  .\install.ps1 -Copy        - Instalar (copia, sem Admin)" -ForegroundColor Gray
Write-Host "  .\install.ps1 -Force       - Reinstalar (backup do existente)" -ForegroundColor Gray
Write-Host "  .\install.ps1 -Uninstall   - Remover instalacao" -ForegroundColor Gray
Write-Host ""
Write-Host "Para atualizar (symlinks): git pull" -ForegroundColor Cyan
Write-Host "Para atualizar (copia):    git pull; .\install.ps1 -Copy -Force" -ForegroundColor Cyan

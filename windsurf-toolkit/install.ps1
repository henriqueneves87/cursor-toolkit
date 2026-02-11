# windsurf-toolkit install.ps1
# Cria symlinks do windsurf-toolkit para os diretórios globais do Windsurf
# Requer: Executar como Administrador (para criar symlinks no Windows)

param(
    [switch]$Force,
    [switch]$Copy,
    [switch]$Uninstall
)

$ErrorActionPreference = "Stop"
$toolkitDir = $PSScriptRoot
$windsurfDir = "$env:USERPROFILE\.windsurf"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  windsurf-toolkit — Instalação" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Toolkit:  $toolkitDir"
Write-Host "Windsurf: $windsurfDir"
Write-Host ""

# Verificar se o diretório do Windsurf existe
if (-not (Test-Path $windsurfDir)) {
    Write-Host "ERRO: Diretório do Windsurf não encontrado: $windsurfDir" -ForegroundColor Red
    Write-Host "Verifique se o Windsurf está instalado." -ForegroundColor Red
    exit 1
}

$targets = @(
    @{ Name = "skills";   Src = "$toolkitDir\skills";   Dst = "$windsurfDir\skills" }
    @{ Name = "commands"; Src = "$toolkitDir\commands"; Dst = "$windsurfDir\commands" }
    @{ Name = "agents";   Src = "$toolkitDir\agents";   Dst = "$windsurfDir\agents" }
    @{ Name = "rules";    Src = "$toolkitDir\rules";    Dst = "$windsurfDir\rules" }
)

# --- UNINSTALL ---
if ($Uninstall) {
    Write-Host "Removendo instalação..." -ForegroundColor Yellow
    foreach ($t in $targets) {
        if (Test-Path $t.Dst) {
            $item = Get-Item $t.Dst -Force
            if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
                # É symlink — remover
                $item.Delete()
                Write-Host "  Removido symlink: $($t.Name)" -ForegroundColor Green
            } else {
                Write-Host "  AVISO: $($t.Dst) não é symlink, não removido" -ForegroundColor Yellow
            }
        } else {
            Write-Host "  $($t.Name) — não encontrado, ignorando" -ForegroundColor Gray
        }
    }
    Write-Host ""
    Write-Host "Desinstalação concluída." -ForegroundColor Green
    exit 0
}

# --- INSTALL ---
foreach ($t in $targets) {
    Write-Host "Configurando $($t.Name)..." -ForegroundColor White

    if (Test-Path $t.Dst) {
        $existing = Get-Item $t.Dst -Force
        
        if ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            # Já é symlink
            if ($Force) {
                $existing.Delete()
                Write-Host "  Symlink existente removido (--Force)" -ForegroundColor Yellow
            } else {
                Write-Host "  Symlink já existe. Use -Force para substituir." -ForegroundColor Yellow
                continue
            }
        } else {
            # Diretório real existente
            if ($Force) {
                # Fazer backup
                $backup = "$($t.Dst)_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
                Rename-Item $t.Dst $backup
                Write-Host "  Backup criado: $backup" -ForegroundColor Yellow
            } elseif ($Copy) {
                # Modo cópia — copiar arquivos para dentro do diretório existente
                Write-Host "  Diretório existe. Copiando arquivos..." -ForegroundColor Yellow
                Copy-Item -Path "$($t.Src)\*" -Destination $t.Dst -Recurse -Force
                Write-Host "  Arquivos copiados para $($t.Dst)" -ForegroundColor Green
                continue
            } else {
                Write-Host "  Diretório já existe. Use -Force (backup+symlink) ou -Copy (copiar arquivos)" -ForegroundColor Yellow
                continue
            }
        }
    }

    if ($Copy) {
        # Modo cópia — criar diretório e copiar
        New-Item -ItemType Directory -Path $t.Dst -Force | Out-Null
        Copy-Item -Path "$($t.Src)\*" -Destination $t.Dst -Recurse -Force
        Write-Host "  Copiado para: $($t.Dst)" -ForegroundColor Green
    } else {
        # Modo symlink (padrão)
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
Write-Host "  Instalação concluída!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Opções disponíveis:" -ForegroundColor Gray
Write-Host "  .\install.ps1              — Instalar (symlinks, requer Admin)" -ForegroundColor Gray
Write-Host "  .\install.ps1 -Copy        — Instalar (cópia, sem Admin)" -ForegroundColor Gray
Write-Host "  .\install.ps1 -Force       — Reinstalar (backup do existente)" -ForegroundColor Gray
Write-Host "  .\install.ps1 -Uninstall   — Remover instalação" -ForegroundColor Gray
Write-Host ""
Write-Host "Para atualizar (symlinks): git pull" -ForegroundColor Cyan
Write-Host "Para atualizar (cópia):    git pull; .\install.ps1 -Copy -Force" -ForegroundColor Cyan

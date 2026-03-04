# cursor-toolkit install.ps1
# Cria symlinks do cursor-toolkit para os diretórios globais do Cursor
# Requer: Executar como Administrador (para criar symlinks no Windows)
# Alternativa: use como plugin Cursor (formato single plugin). Ver README.
param(
    [switch]$Force,
    [switch]$Copy,
    [switch]$Uninstall
)

$ErrorActionPreference = "Stop"
$toolkitDir = $PSScriptRoot
$cursorDir = "$env:USERPROFILE\.cursor"

Write-Host ""
Write-Host 'cursor-toolkit - Instalacao (symlinks)' -ForegroundColor Cyan
Write-Host 'Alternativa: use como plugin Cursor. Ver README.' -ForegroundColor Gray
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Toolkit: $toolkitDir"
Write-Host "Cursor:  $cursorDir"
Write-Host ""

# Verificar se o diretório do Cursor existe
if (-not (Test-Path $cursorDir)) {
    Write-Host "ERRO: Diretorio do Cursor nao encontrado: $cursorDir" -ForegroundColor Red
    Write-Host 'Verifique se o Cursor esta instalado.' -ForegroundColor Red
    exit 1
}

$targets = @(
    @{ Name = "skills";   Src = "$toolkitDir\skills";   Dst = "$cursorDir\skills" }
    @{ Name = "commands"; Src = "$toolkitDir\commands";  Dst = "$cursorDir\commands" }
    @{ Name = "agents";   Src = "$toolkitDir\agents";    Dst = "$cursorDir\agents" }
    @{ Name = "rules";    Src = "$toolkitDir\rules";    Dst = "$cursorDir\rules" }
)

# --- UNINSTALL ---
if ($Uninstall) {
    Write-Host 'Removendo instalacao...' -ForegroundColor Yellow
    foreach ($t in $targets) {
        if (Test-Path $t.Dst) {
            $item = Get-Item $t.Dst -Force
            if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
                # Eh symlink - remover
                $item.Delete()
                Write-Host "  Removido symlink: $($t.Name)" -ForegroundColor Green
            } else {
                Write-Host "  AVISO: $($t.Dst) nao eh symlink, nao removido" -ForegroundColor Yellow
            }
        } else {
            Write-Host "  $($t.Name) - nao encontrado, ignorando" -ForegroundColor Gray
        }
    }
    Write-Host ""
    Write-Host 'Desinstalacao concluida.' -ForegroundColor Green
    exit 0
}

# --- INSTALL ---
foreach ($t in $targets) {
    Write-Host "Configurando $($t.Name)..." -ForegroundColor White

    if (Test-Path $t.Dst) {
        $existing = Get-Item $t.Dst -Force
        
        if ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            # Ja eh symlink
            if ($Force) {
                $existing.Delete()
                Write-Host '  Symlink existente removido (-Force)' -ForegroundColor Yellow
            } else {
                Write-Host '  Symlink ja existe. Use -Force para substituir.' -ForegroundColor Yellow
                continue
            }
        } else {
            # Diretorio real existente
            if ($Force) {
                # Fazer backup
                $backup = "$($t.Dst)_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
                Rename-Item $t.Dst $backup
                Write-Host "  Backup criado: $backup" -ForegroundColor Yellow
            } elseif ($Copy) {
                # Modo copia - copiar arquivos para dentro do diretorio existente
                Write-Host '  Diretorio existe. Copiando arquivos...' -ForegroundColor Yellow
                Copy-Item -Path "$($t.Src)\*" -Destination $t.Dst -Recurse -Force
                Write-Host "  Arquivos copiados para $($t.Dst)" -ForegroundColor Green
                continue
            } else {
                Write-Host '  Diretorio ja existe. Use -Force (backup+symlink) ou -Copy (copiar arquivos)' -ForegroundColor Yellow
                continue
            }
        }
    }

    if ($Copy) {
        # Modo copia - criar diretorio e copiar
        New-Item -ItemType Directory -Path $t.Dst -Force | Out-Null
        Copy-Item -Path "$($t.Src)\*" -Destination $t.Dst -Recurse -Force
        Write-Host "  Copiado para: $($t.Dst)" -ForegroundColor Green
    } else {
        # Modo symlink (padrao)
        try {
            New-Item -ItemType SymbolicLink -Path $t.Dst -Target $t.Src -Force | Out-Null
            Write-Host "  Symlink criado: $($t.Dst) -> $($t.Src)" -ForegroundColor Green
        } catch {
            Write-Host '  ERRO ao criar symlink. Execute como Administrador ou use -Copy' -ForegroundColor Red
            Write-Host '  Fallback: copiando arquivos...' -ForegroundColor Yellow
            New-Item -ItemType Directory -Path $t.Dst -Force | Out-Null
            Copy-Item -Path "$($t.Src)\*" -Destination $t.Dst -Recurse -Force
            Write-Host "  Copiado para: $($t.Dst)" -ForegroundColor Green
        }
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host '  Instalacao concluida!' -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host 'Opcoes disponiveis:' -ForegroundColor Gray
Write-Host '  .\install.ps1              - Instalar (symlinks, requer Admin)' -ForegroundColor Gray
Write-Host '  .\install.ps1 -Copy        - Instalar (copia, sem Admin)' -ForegroundColor Gray
Write-Host '  .\install.ps1 -Force       - Reinstalar (backup do existente)' -ForegroundColor Gray
Write-Host '  .\install.ps1 -Uninstall   - Remover instalacao' -ForegroundColor Gray
Write-Host ""
Write-Host 'Para atualizar (symlinks): git pull' -ForegroundColor Cyan
Write-Host 'Para atualizar (copia):    git pull; .\install.ps1 -Copy -Force' -ForegroundColor Cyan

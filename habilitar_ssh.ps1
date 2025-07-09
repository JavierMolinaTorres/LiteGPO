# ----------------------------------------------------------
# Script: habilitar_ssh.ps1
# Descripción: Instala y configura OpenSSH Server en Windows 11
# Este script debe ejecutarse en el ordenador remoto donde queremos aplicar una política de grupo (GPO).
# Es un paso ineludible que debe hacerse siempre antes de empezar con LiteGPO.
# El script instala (si no estaba presente) openSSH, configura inicio automático y permite puerto 22 por el firewall
# Se instala en Power Shell con permisos de administrador
# Para comprobar si funciona, en el mismo ordenador e igualmente con Power Shell podemos escribir 
# ssh admin@localhost (si no fuera admin el administrador, cambiar al que corresponda para esa máquina en particular)
# Nos pedirá reconocer el fingerprint de la máquina para autorizar la conexión y luego el password.
# tras ello tendremos algo parecido a esto: admin@DESKTOP-xxxx C:\Users\admin>
# lo cual habilita la recepción remota de GPOs
# ----------------------------------------------------------

Write-Host "🔧 Instalando y configurando OpenSSH Server..." -ForegroundColor Cyan

# Verificar si OpenSSH Server ya está instalado
$sshInstalled = Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*' | Select-Object -ExpandProperty State
if ($sshInstalled -ne 'Installed') {
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
} else {
    Write-Host "ℹ️ OpenSSH Server ya estaba instalado." -ForegroundColor Yellow
}

# Iniciar el servicio y configurar inicio automático
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# Abrir puerto 22 en el firewall si no existe ya
if (-not (Get-NetFirewallRule -Name "SSH-In-TCP" -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -Name "SSH-In-TCP" -DisplayName "OpenSSH Server (Entrada)" `
        -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
}

# Verificar estado del servicio
Get-Service sshd

Write-Host "`n✅ OpenSSH Server instalado y configurado. Ya puedes conectarte con ssh usuario@IP." -ForegroundColor Green

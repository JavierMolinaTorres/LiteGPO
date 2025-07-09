# ----------------------------------------------------------
# Script: ejecutar_remoto_ssh.ps1
# Descripción: Ejecuta un comando PowerShell remoto usando SSH
# Este script debe ejecutarse en PowerShell con permisos de administrador para verificar que podemos ver la máquina remota 
# y ejecutar unos comandos muy simples a modo de verificación. En este caso nos mostrará el nombre de la máquina remota, la
# fecha y hora, el sistema operativo y la versión de Windows. Para efectuar la prueba de manera eficiente es preciso conocer
# la ip o nombre de la máquina (en este caso verificar que puede hacerse ping al mismo, en caso contrario contra la ip directa)
# el usuario administrador y su password. Debemos también estar seguros que la máquina remota posee SSH y el firewall está habilitado
# para dejar pasar el puerto 22
# El resultado sería algo parecido a:
# Ejecutando
# en
# DESKTOP-xxxxxxx"
#
# Fecha:
# 2025-03-09 05:46:39
#
# OsName                   WindowsVersion
# ------                   --------------
# Microsoft Windows 11 Pro 2009
# ----------------------------------------------------------
# Parámetros
$usuario = "admin"       # Debe modificarse según el usuario administrador de la máquina remota
$equipo = "192.xxx.xxx.xxx"    # IP o nombre del equipo remoto
$scriptRemoto = {
    Write-Output "📡 Ejecutando en $env:COMPUTERNAME"
    Write-Output "🕒 Fecha: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    Get-ComputerInfo | Select-Object OSName, WindowsVersion
}

# Convertir ScriptBlock a string con comillas escapadas
$scriptStr = $scriptRemoto.ToString().Replace('"', '`"')

# Comando SSH completo
$comando = "ssh $usuario@$equipo `"powershell -NoProfile -ExecutionPolicy Bypass -Command `"$scriptStr`"`""

# Ejecutar
Write-Host "🔧 Ejecutando SSH remota en $equipo..." -ForegroundColor Cyan
Invoke-Expression $comando

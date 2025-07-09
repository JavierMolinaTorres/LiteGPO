# Este script reactiva los usb de la máquina remota. Es la contra-GPO de desactivar_usb_storage.ps1
# Parámetros
$usuario = "admin"       # Cambiar según el usuario con privilegios administrativos en la máquina remota
$equipo = "192.xxx.xxx.xxx"    # IP o nombre del equipo remoto

# Script remoto que reactiva el almacenamiento USB
$scriptRemoto = {
    try {
        Write-Output "📡 Ejecutando en $env:COMPUTERNAME"
        Write-Output "♻️ Reactivando almacenamiento USB..."

        # Restaurar el valor del servicio USBSTOR
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR' -Name 'Start' -Value 3
        Start-Service -Name 'usbstor' -ErrorAction SilentlyContinue

        Write-Output "✅ Almacenamiento USB reactivado correctamente."
    }
    catch {
        Write-Error "❌ Error al reactivar el almacenamiento USB: $_"
    }
}

# Convertir ScriptBlock a string con comillas escapadas
$scriptStr = $scriptRemoto.ToString().Replace('"', '`"')

# Comando SSH completo
$comando = "ssh $usuario@$equipo `"powershell -NoProfile -ExecutionPolicy Bypass -Command `"$scriptStr`"`""

# Ejecutar
Write-Host "🔧 Conectando por SSH a $equipo para reactivar USB..." -ForegroundColor Green
Invoke-Expression $comando

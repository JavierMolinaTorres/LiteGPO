# Desactiva el driver de almacenamiento USB sin afectar teclado, ratón ni dock
# Dado que algunos teclados cuentan con almacenamiento, en este caso particular no lo desactivarían
# Este script se ejecuta en el máquina local sobre la máquina remota.
# Parámetros
$usuario = "admin"       # Cambiar según el usuario con privilegios administrativos en la máquina remota
$equipo = "192.xxx.xxx.xxx"    # IP o nombre del equipo remoto

# Script remoto que desactiva el almacenamiento USB (sin afectar teclado/ratón)
$scriptRemoto = {
    try {
        Write-Output "📡 Ejecutando en $env:COMPUTERNAME"
        Write-Output "🛡️ Desactivando almacenamiento USB..."
        
        # Desactivar el servicio USBSTOR
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR' -Name 'Start' -Value 4
        Stop-Service -Name 'usbstor' -ErrorAction SilentlyContinue

        Write-Output "✅ Almacenamiento USB deshabilitado correctamente."
    }
    catch {
        Write-Error "❌ Error al desactivar el almacenamiento USB: $_"
    }
}

# Convertir ScriptBlock a string con comillas escapadas
$scriptStr = $scriptRemoto.ToString().Replace('"', '`"')

# Comando SSH completo
$comando = "ssh $usuario@$equipo `"powershell -NoProfile -ExecutionPolicy Bypass -Command `"$scriptStr`"`""

# Ejecutar
Write-Host "🔧 Conectando por SSH a $equipo para aplicar hardening USB..." -ForegroundColor Cyan
Invoke-Expression $comando

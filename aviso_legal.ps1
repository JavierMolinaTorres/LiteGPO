# Este script permite mostrar al usuario una advertencia corporativa y/o legal sobre el uso del equipo.
# El texto se debe adaptar a las necesidades de cada corporación
# Parámetros
$usuario = "admin"
$equipo = "192.xxx.xxx.xxx"

# Script remoto que impone el aviso legal en la pantalla de inicio de sesión
$scriptRemoto = {
    try {
        Write-Output "📡 Ejecutando en $env:COMPUTERNAME"
        Write-Output "🛑 Aplicando aviso legal al inicio de sesión..."

        $caption = "ADVERTENCIA"
        $texto = @"
Está empleando un ordenador perteneciente a XXXXXXX.
Como equipo corporativo está expresamente prohibido usarlo con fines particulares y/o almacenar información personal,
así como para acceder a cuentas, páginas webs y otros equipos no autorizados.
El infringimiento de esta regla implica la retirada inmediata del equipo, sin menoscabo de otras acciones disciplinarias.
"@

        Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LegalNoticeCaption" -Value $caption
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LegalNoticeText" -Value $texto

        Write-Output "✅ Advertencia legal configurada correctamente."
    }
    catch {
        Write-Error "❌ Error al configurar la advertencia legal: $_"
    }
}

# Convertir ScriptBlock a string con comillas escapadas
$scriptStr = $scriptRemoto.ToString().Replace('"', '`"')

# Comando SSH completo
$comando = "ssh $usuario@$equipo `"powershell -NoProfile -ExecutionPolicy Bypass -Command `"$scriptStr`"`""

# Ejecutar
Write-Host "🔧 Aplicando política de advertencia en $equipo..." -ForegroundColor Yellow
Invoke-Expression $comando

<#
.SYNOPSIS
    Exporta los eventos 4625 (inicio de sesión fallido) del registro de Seguridad
    a un CSV y calcula el hash SHA-256 del resultado.

.DESCRIPTION
    Proyecto 06 - Revisión de logs (Módulo 9, Seguridad de Terminales).
    Lee el registro de Seguridad, extrae los campos relevantes de cada evento
    y los guarda ordenados por hora. El hash permite verificar la integridad
    del CSV generado.

.PARAMETER Salida
    Ruta del CSV de salida. Por defecto: .\eventos_4625.csv

.PARAMETER Id
    ID de evento a exportar. Por defecto: 4625.

.NOTES
    Ejecutar PowerShell como Administrador (el registro de Seguridad lo exige).
    Uso:  .\exportar-eventos-4625.ps1
          .\exportar-eventos-4625.ps1 -Id 4624 -Salida .\eventos_4624.csv
#>

param(
    [string]$Salida = ".\eventos_4625.csv",
    [int]$Id = 4625
)

$eventos = Get-WinEvent -FilterHashtable @{ LogName = 'Security'; Id = $Id } -ErrorAction SilentlyContinue

if (-not $eventos) {
    Write-Host "No se encontraron eventos con ID $Id (o falta ejecutar como Administrador)." -ForegroundColor Yellow
    return
}

$resultado = foreach ($e in $eventos) {
    $xml = [xml]$e.ToXml()
    $campos = @{}
    foreach ($nodo in $xml.Event.EventData.Data) {
        $campos[$nodo.Name] = $nodo.'#text'
    }

    [PSCustomObject]@{
        Hora        = $e.TimeCreated.ToString('yyyy-MM-dd HH:mm:ss')
        IdEvento    = $e.Id
        Cuenta      = $campos['TargetUserName']
        Equipo      = $campos['WorkstationName']
        TipoLogon   = $campos['LogonType']
        EstadoError = $campos['Status']
        SubEstado   = $campos['SubStatus']
        IPOrigen    = $campos['IpAddress']
    }
}

$resultado | Sort-Object Hora | Export-Csv -Path $Salida -NoTypeInformation -Encoding UTF8

Write-Host "Eventos exportados: $($resultado.Count) -> $Salida" -ForegroundColor Green
Get-FileHash -Path $Salida -Algorithm SHA256 | Format-List
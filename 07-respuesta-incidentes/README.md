# Respuesta a Incidentes con Simulación Forense (NIST SP 800-61)

Proyecto práctico del **Módulo 10 — Principios, prácticas y procesos de ciberseguridad**, enfocado en llevar la teoría de respuesta a incidentes a una simulación real en laboratorio virtual, conectando el manejo del incidente con los fundamentos de forense digital.

## Objetivo

Construir un flujo de respuesta a incidentes claro y aplicable —basado en **NIST SP 800-61**— respaldado por un diagrama de decisiones, una simulación práctica en Windows y documentación forense básica (orden de volatilidad, hashes SHA-256, cadena de custodia y bitácora).

## Escenario de la simulación

Se plantea el rol de **analista de soporte de Nivel 1** ante una alerta o reporte asociado a un archivo sospechoso (`factura_pendiente.com` con cadena EICAR) en un equipo con Windows. El ejercicio recorre la confirmación del caso, la clasificación de severidad, el aislamiento de red sin apagar la VM para cuidar la evidencia volátil, la recolección de red/procesos/eventos, el cálculo de hashes y el registro post-incidente.

## Herramientas utilizadas

- **Marco y modelado:** NIST SP 800-61 y **draw.io** para el diagrama de flujo.
- **Entorno de pruebas:** **VirtualBox** con máquina virtual **Windows** aislada y archivo de prueba **EICAR**.
- **Recolección y verificación:** **PowerShell**, `netstat -ano`, `tasklist /v`, **Visor de Eventos** (`Get-EventLog` / `Get-WinEvent`) y `Get-FileHash` (**SHA-256**).

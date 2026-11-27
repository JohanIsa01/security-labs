# Formulario de Cadena de Custodia

- **ID de caso:** IR-SIM-001
- **Entorno:** Laboratorio aislado en VirtualBox (simulación con archivo de prueba EICAR)
- **Recolector / Analista:** [Tu nombre o alias]
- **Equipo origen:** VM Windows en VirtualBox ([Nombre de la VM])
- **Algoritmo de integridad:** SHA-256

## Registro de evidencias

| ID Evidencia | Archivo / Evidencia recolectada | Hash SHA-256 | Ubicación de resguardo |
| :--- | :--- | :--- | :--- |
| EV-01 | `01_red_netstat.txt` (conexiones de red y puertos activos) | `23B12A6631D1CA6E42F9564DB0D02ADA72245C94A92774F8FBB1D4F4672EC76C` | `C:\Evidencia_IR\` en la VM y copia en equipo anfitrión |
| EV-02 | `02_procesos_tasklist.txt` (procesos y servicios activos en memoria) | `D3CFA08DC9CC9F967A511F14CF9B9868B4B61B4C1BB1370BB29FCD28FE6E5C0C` | `C:\Evidencia_IR\` en la VM y copia en equipo anfitrión |
| EV-03 | `03_eventos_app.txt` (últimos 50 eventos del registro Application) | `6DFE8C58F519E05A0337D402970C81AEB21AAFD93618FCAB63ED13A019197747` | `C:\Evidencia_IR\` en la VM y copia en equipo anfitrión |
| EV-04 | `04_eventos_defender.txt` (últimos 20 eventos de Windows Defender Operational) | `6069A7B3E628695F2A1BC0DABA37A0DD95C44D76700A2CE369A090F9BD295146` | `C:\Evidencia_IR\` en la VM y copia en equipo anfitrión |

## Control de transferencias y custodia

| Etapa | Entregado por | Recibido por | Motivo y verificación de integridad |
| :--- | :--- | :--- | :--- |
| Recolección inicial | Sistema operativo de la VM | [Tu nombre o alias] (Analista IR) | Extracción ordenada de red, procesos y registros de eventos en `C:\Evidencia_IR\` |
| Cálculo de hash | Archivos de evidencia en `C:\Evidencia_IR\` | `hashes_sha256.txt` (PowerShell) | Generación de hashes SHA-256 mediante `Get-FileHash` sin alterar archivos origen |
| Resguardo de laboratorio | VM aislada en VirtualBox | Carpeta del repositorio (`simulacion/`) | Copia de archivos, capturas y registro de hashes para análisis y documentación |

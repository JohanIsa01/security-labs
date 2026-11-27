# Formulario de Cadena de Custodia

- **ID de caso:** IR-SIM-001
- **Entorno:** Laboratorio aislado en VirtualBox (simulación con archivo EICAR)
- **Recolector / Analista:** [Tu nombre o alias]
- **Equipo origen (VM):** [Nombre del host/VM en Windows]

## Registro de evidencias

| ID Evidencia | Archivo / Descripción | Fecha y hora de recolección | Algoritmo y Hash SHA-256 | Ubicación de resguardo |
| :--- | :--- | :--- | :--- | :--- |
| EV-01 | `01_red_netstat.txt` (conexiones de red y puertos activos) | [YYYY-MM-DD HH:MM] | SHA-256: `23B12A6631D1CA6E42F9564DB0D02ADA72245C94A92774F8FBB1D4F4672EC76C` | `C:\Evidencia_IR\` (VM) y copia en Host |
| EV-02 | `02_procesos_tasklist.txt` (procesos y servicios en memoria) | [YYYY-MM-DD HH:MM] | SHA-256: `D3CFA08DC9CC9F967A511F14CF9B9868B4B61B4C1BB1370BB29FCD28FE6E5C0C` | `C:\Evidencia_IR\` (VM) y copia en Host |
| EV-03 | `03_eventos_app.txt` (últimos 50 eventos de Aplicación) | [YYYY-MM-DD HH:MM] | SHA-256: `6DFE8C58F519E05A0337D402970C81AEB21AAFD93618FCAB63ED13A019197747` | `C:\Evidencia_IR\` (VM) y copia en Host |
| EV-04 | `04_eventos_defender.txt` (últimos 20 eventos de Defender Operational) | [YYYY-MM-DD HH:MM] | SHA-256: `6069A7B3E628695F2A1BC0DABA37A0DD95C44D76700A2CE369A090F9BD295146` | `C:\Evidencia_IR\` (VM) y copia en Host |

## Control de transferencias / accesos

| Fecha y hora | Entregado por | Recibido por | Motivo / Verificación de integridad |
| :--- | :--- | :--- | :--- |
| [YYYY-MM-DD HH:MM] | [Tu nombre] (VM Windows) | [Tu nombre] (Carpeta de laboratorio) | Recolección inicial y cálculo de hashes SHA-256 en PowerShell |

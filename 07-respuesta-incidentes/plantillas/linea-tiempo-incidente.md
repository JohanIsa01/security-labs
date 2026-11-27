# Bitácora de Línea de Tiempo del Incidente

- **ID de caso:** IR-SIM-001
- **Escenario:** Simulación de alerta por archivo sospechoso con cadena de prueba EICAR en máquina virtual Windows aislada
- **Nota de registro:** Secuencia ordenada de eventos y acciones ejecutadas durante la simulación práctica

| Secuencia | Evidencia / Hallazgo observado | Acción tomada | Fase NIST SP 800-61 |
| :--- | :--- | :--- | :--- |
| Evento 1 | Creación del archivo de prueba EICAR y activación de alerta/detección en el equipo | Registro del caso, verificación del archivo y evaluación inicial de severidad | Detección y análisis |
| Evento 2 | Confirmación de incidente controlado en entorno de laboratorio | Desconexión del adaptador de red en VirtualBox sin apagar la VM para preservar RAM | Contención |
| Evento 3 | VM aislada de la red externa | Recolección de conexiones de red (`netstat -ano`) y procesos activos (`tasklist /v`) | Detección y análisis / Contención |
| Evento 4 | Salidas volátiles guardadas en `C:\Evidencia_IR\` | Exportación de eventos de `Application` y `Microsoft-Windows-Windows Defender/Operational` | Detección y análisis |
| Evento 5 | Conjunto de evidencias `.txt` reunido | Cálculo de hashes SHA-256 (`Get-FileHash`) y respaldo visual en capturas de pantalla | Contención / Preservación |
| Evento 6 | Evidencias verificadas y documentadas | Completado del formulario de cadena de custodia y bitácora del incidente | Actividad posterior al incidente |

# Informe Post-Incidente y Lecciones Aprendidas

- **ID de caso:** IR-SIM-001
- **Marco de referencia:** NIST SP 800-61
- **Entorno:** Laboratorio propio y aislado en VirtualBox (simulación con archivo de prueba EICAR)

## 1. Resumen de la simulación

Se simuló una alerta de seguridad asociada a un archivo de prueba inofensivo (EICAR) en una máquina virtual con Windows. Se siguió el flujo definido en el diagrama y playbook: triaje inicial, evaluación de severidad, contención mediante desconexión de red sin apagar el equipo, recolección ordenada de evidencia volátil y registros del sistema, cálculo de hashes SHA-256 y documentación forense básica.

## 2. Qué funcionó bien

- **Aislamiento rápido sin perder estado volátil:** Desconectar el adaptador de red desde la VM sin apagarla permitió mantener el estado de procesos y conexiones sin destruir información en memoria de forma abrupta.
- **Orden lógico de recolección y verificación:** Exportar primero la actividad de red y procesos (`netstat -ano` y `tasklist /v`), luego los registros de eventos y finalmente calcular hashes SHA-256 (`Get-FileHash`) dio trazabilidad e integridad a los archivos generados.
- **Claridad del flujo de decisión:** Contar con un diagrama de flujo previo facilitó seguir los pasos sin improvisar ni omitir la validación de integridad.

## 3. Qué fallaría o se quedaría corto en un incidente real

- **EICAR no refleja malware real:** EICAR activa alertas de antivirus, pero no ejecuta persistencia, movimiento lateral, ofuscación ni evasión de defensas. En un caso real habría que investigar rutas de ejecución, tareas programadas, claves de registro y conexiones salientes maliciosas.
- **Comandos básicos vs. adquisición forense profunda:** `netstat -ano` y `tasklist /v` dan una foto útil y rápida, pero en un análisis forense exigente se necesitarían herramientas especializadas para volcado de memoria RAM, análisis de procesos ocultos, registros de seguridad/Sysmon y recolección de artefactos del disco sin modificar marcas de tiempo.
- **Falta de presión operativa y dependencias externas:** En un entorno real intervienen múltiples equipos, sistemas de tickets, políticas de negocio que dificultan aislar un servidor crítico al instante y riesgo de que el atacante ya esté operando dentro de la red.
- **Errores humanos al escribir comandos en consola:** Durante la práctica se produjeron pequeños fallos de sintaxis y redirección en PowerShell al ejecutar los comandos, algo que en una respuesta real consume minutos valiosos si no se tienen comandos probados y estandarizados.

## 4. Mejoras propuestas para el playbook

- **Incluir un anexo de comandos validados:** Añadir una sección de referencia rápida con comandos de PowerShell y CMD ya probados para evitar errores tipográficos o de redirección durante la respuesta.
- **Detallar criterios de escalamiento por tipo de activo:** Precisar cómo varía la decisión de aislar o escalar según si el equipo es un puesto de usuario, un servidor de aplicaciones o un controlador de dominio.
- **Ampliar la fase de erradicación y recuperación:** Especificar pasos concretos de verificación posterior a la limpieza (revisión de persistencia, cambio de credenciales si aplica y monitoreo reforzado tras reconectar).

## 5. Aviso de laboratorio

Todo el ejercicio, las pruebas y los registros presentados en este proyecto se realizaron exclusivamente en un entorno de laboratorio propio, controlado y aislado mediante máquina virtual, sin utilizar malware real ni afectar sistemas de terceros.

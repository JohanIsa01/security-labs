# Playbook de Respuesta a Incidentes

- **Marco de referencia:** NIST SP 800-61 (Guía de manejo de incidentes)
- **Rol en el escenario:** Analista de soporte de Nivel 1
- **Escenario base:** Un usuario reporta que su equipo con Windows actúa raro o salta una alerta de seguridad tras abrir un archivo sospechoso (`factura_pendiente.com` / cadena de prueba EICAR en laboratorio).

## 1. Preparación

Antes de que ocurra un incidente, hay que tener el terreno listo para no perder tiempo buscando herramientas o contactos a ciegas:

- **Herramientas disponibles:** Terminal de PowerShell y CMD con privilegios de administrador, Visor de Eventos de Windows, Windows Security / antivirus del endpoint, y una carpeta dedicada para recolectar evidencia (`C:\Evidencia_IR\`) sin mezclar archivos.
- **Contactos y escalamiento:** Tener claro quién es el responsable de Respuesta a Incidentes (IR Lead) y qué canal usar para avisarle rápido si el caso sube de severidad.
- **Copias de seguridad:** Verificar que existan respaldos recientes del sistema o de los datos críticos, y en entornos de prueba/laboratorio contar con instantáneas (snapshots) limpias para restaurar sin dramas.

## 2. Detección y análisis

Cuando llega una alerta del antivirus o un reporte de usuario, lo primero es verificar si hay algo real detrás y qué tan grave es.

### Confirmar si es un incidente o un falso positivo
1. Registrar la hora exacta en que se recibe la alerta o el reporte.
2. Revisar el contexto del evento: de dónde vino el archivo, qué proceso lo abrió, si hubo ejecución real o conexión de red inesperada y si otros equipos muestran síntomas parecidos.
3. Si se confirma que es un falso positivo (por ejemplo, una herramienta interna legítima o una prueba autorizada sin riesgo), documentarlo y cerrar el caso. Si hay indicios reales de amenaza o comportamiento anómalo, tratarlo como incidente.

### Clasificación por severidad
Evaluar el caso según **impacto operativo**, **datos en juego** y **esfuerzo de recuperación**:
- **Baja:** Alerta aislada sin ejecución confirmada, sin acceso a datos sensibles ni propagación. Se puede gestionar en Nivel 1 con supervisión.
- **Media:** Comportamiento anómalo o amenaza contenida en un equipo con posible impacto en el trabajo del usuario. Requiere escalar al IR Lead en menos de 15 minutos.
- **Alta / Crítica:** Ejecución confirmada de malware, riesgo de propagación lateral, afectación a múltiples equipos o exposición de información sensible. Escalamiento inmediato (menos de 15 minutos) al IR Lead.

## 3. Contención

El objetivo aquí es frenar el avance del problema sin destruir evidencia valiosa:

- **Aislar el equipo sin apagarlo:** Desconectar la interfaz de red (desconectar el cable o desmarcar el adaptador de red en la VM) para cortar comunicación entrante y saliente, **sin apagar ni reiniciar** la máquina. Apagar el equipo de golpe borra información volátil en la memoria RAM y corta el estado vivo de los procesos y conexiones.
- **Preservar evidencia por orden de volatilidad:** Recolectar primero lo que se pierde más rápido y dejar al final lo más estable:
  1. Conexiones de red y puertos activos (`netstat -ano`).
  2. Procesos activos y servicios en memoria (`tasklist /v`).
  3. Registros de eventos del sistema y seguridad/antivirus (Visor de Eventos / PowerShell).
- **Registrar integridad:** Calcular hashes SHA-256 (`Get-FileHash`) de los archivos recolectados y documentar todo en la cadena de custodia y la bitácora.
- **Revisar alcance:** Comprobar si hay más equipos afectados o con síntomas similares; si aparecen más, aplicar contención en ellos también.

## 4. Erradicación y recuperación

Una vez contenida la amenaza y recolectada la evidencia, toca limpiar el origen y devolver el equipo a la operación normal con cuidado:

- **Erradicación:** Eliminar el archivo malicioso o de prueba (como el archivo EICAR en la simulación), detener procesos sospechosos si siguen activos, revisar posibles mecanismos de persistencia (inicio automático, tareas o registros alterados) y aplicar parches o actualizaciones pendientes.
- **Recuperación:** Validar la integridad del sistema, reconectar el equipo a la red de forma controlada y mantener un monitoreo cercano durante las horas siguientes para asegurarse de que el problema no vuelva a aparecer.

## 5. Actividad posterior al incidente (Post-incidente)

Cuando el incidente queda resuelto:

- Cerrar la línea de tiempo y la documentación forense del caso.
- Redactar el informe de **lecciones aprendidas**: qué funcionó bien, qué limitaciones aparecieron y qué ajustes necesita el playbook.
- Compartir los hallazgos con el equipo para mejorar la detección y la respuesta en futuros casos.

## 6. Roles y escalamiento

| Rol | Responsabilidad principal | Cuándo interviene / se le avisa |
| :--- | :--- | :--- |
| **Analista de Soporte (Nivel 1)** | Triage inicial, registro de hora, validación preliminar, contención básica, recolección

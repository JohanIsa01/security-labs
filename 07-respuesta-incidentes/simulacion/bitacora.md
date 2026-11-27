# Bitácora Técnica de Simulación (IR-SIM-001)

- **Caso:** IR-SIM-001 - Detección de archivo de prueba EICAR en endpoint Windows
- **Entorno:** Máquina virtual Windows aislada en VirtualBox
- **Rol:** Analista de soporte de Nivel 1
- **Objetivo:** Ejecutar el playbook de respuesta a incidentes (NIST SP 800-61), aplicar contención sin apagar el equipo, recolectar evidencia por orden de volatilidad y validar integridad mediante SHA-256.

---

## 1. Desarrollo paso a paso

### Paso 1: Detección y triaje inicial
- **Observación:** Se generó el archivo de prueba estándar antivirus **EICAR** (`68 bytes`) dentro de la máquina virtual para simular la llegada de un archivo sospechoso y la activación de una alerta en Windows Security.
- **Acción:** Se registró el incidente, se confirmó que correspondía a una actividad controlada de laboratorio y se clasificó para aplicar el protocolo de contención y preservación.
- **Evidencia visual:** `capturas/01-alerta-eicar.png`

### Paso 2: Contención (Aislamiento sin apagar)
- **Acción:** Se desconectó el adaptador de red de la máquina virtual desde VirtualBox **sin apagar ni reiniciar** el sistema operativo.
- **Justificación forense:** Mantener el equipo encendido conserva el contenido de la memoria RAM, los procesos en ejecución y el estado de las conexiones de red activas antes de que se pierdan al cortar energía.
- **Evidencia visual:** `capturas/02-aislamiento-red.png`

### Paso 3: Recolección de evidencia por orden de volatilidad
Con PowerShell ejecutado como Administrador, se creó el directorio de trabajo `C:\Evidencia_IR\` y se extrajeron los artefactos de mayor a menor volatilidad:

1. **Conexiones de red y puertos activos:**
   ```powershell
   netstat -ano > C:\Evidencia_IR\01_red_netstat.txt

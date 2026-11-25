
# Hardening en Linux - Línea Base, Controles y Medición

## 1. Objetivo y entorno

- **Objetivo:** Reducir la superficie de ataque del sistema Linux y documentar el impacto real mediante métricas y evidencia verificable antes y después de los cambios.
- **Sistema operativo objetivo (VM):** Kali Linux (kali-rolling, amd64) en entorno de laboratorio virtualizado.
- **Hipervisor / Entorno de laboratorio:** VirtualBox (`virtualbox-guest-utils.service` activo).
- **Herramientas utilizadas:** `lynis`, `ss`, `systemctl`, `ufw`, `sha256sum`, `unattended-upgrades`.

## 2. Metodología

1. **Snapshot inicial:** Captura del estado limpio de la VM antes de modificar configuraciones.
2. **Fase 1 - Línea base ("Antes"):** Recolección de métricas de seguridad con Lynis (`hardening_index=60`), puertos en escucha, servicios habilitados (35 unidades), estado de firewall y cálculo de hashes SHA-256 de la evidencia.
3. **Fase 2 - Aplicación de controles:** Ejecución documentada de mejoras de configuración (actualizaciones, firewall UFW, deshabilitación de `ModemManager.service` y `pcscd.socket`, revisión de privilegios y activación de `unattended-upgrades`).
4. **Fase 3 - Medición ("Después"):** Reejecución de auditoría con Lynis (`hardening_index=65`), comprobación de sockets y servicios (`34` unidades habilitadas), generación de `hashes_despues.txt` y comparación cuantitativa.
5. **Fase 5 - Análisis y lecciones aprendidas:** Registro de limitaciones, riesgos evitados y referencia a CIS Benchmarks.

## 3. Línea base ("Antes") e integridad de evidencia

- **Hardening Index inicial (Lynis):** `60` (`evidencia/lynis-report.dat`)
- **Unidades `enabled` iniciales:** `35` (`evidencia/servicios_antes.txt`)
- **Archivo de hashes inicial:** `linux/evidencia/hashes_antes.txt`
- **Evidencias recolectadas:**
  - `evidencia/lynis-report.dat` (reporte de auditoría inicial)
  - `evidencia/ss_antes.txt` (puertos y sockets en escucha)
  - `evidencia/servicios_antes.txt` (listado de servicios y timers habilitados)
  - `evidencia/ufw_antes.txt` (estado inicial del firewall)

## 4. Tabla de cambios aplicados

| # | Control aplicado | Motivo (riesgo / superficie reducida) | Comando / configuración clave | Resultado / evidencia |
| :---: | :--- | :--- | :--- | :--- |
| 1 | Actualización de paquetes | Corregir vulnerabilidades conocidas en paquetes instalados | `sudo apt update && sudo apt upgrade -y` | Aplicado |
| 2 | Instalación y política de entrada UFW | Bloquear conexiones entrantes no solicitadas por defecto | `sudo apt install ufw -y && sudo ufw default deny incoming` | `Default: deny (incoming)` |
| 3 | Política de salida UFW | Permitir tráfico saliente necesario para actualizaciones y red | `sudo ufw default allow outgoing` | `allow (outgoing)` |
| 4 | Activación persistente de UFW | Aplicar reglas de filtrado de red y habilitar inicio automático | `sudo ufw enable` | `Status: active`, `Logging: on (low)` |
| 5 | Deshabilitación de servicios innecesarios | Reducir demonios/sockets no requeridos en la VM de laboratorio | `sudo systemctl disable --now ModemManager.service pcscd.socket` | Deshabilitados y detenidos |
| 6 | Usuarios y privilegios (`sudo`) | Evitar sesiones prolongadas como `root` y mantener trazabilidad | Uso de cuenta estándar (`johan`) + `sudo` | Verificado |
| 7 | Endurecimiento SSH *(si aplica)* | Reducir superficie de acceso remoto y fuerza bruta | Revisión de `/etc/ssh/sshd_config` (`PermitRootLogin` / claves) | *Completar según estado del servicio* |
| 8 | Actualizaciones automáticas | Aplicar parches de seguridad de forma periódica | `sudo apt install unattended-upgrades -y && sudo dpkg-reconfigure --priority=low unattended-upgrades` | Configurado (`<Sí>`) |
| 9 | Opcional: `fail2ban` / `auditd` | Mitigar reintentos de autenticación / registrar eventos | *(Completar si se instala)* | *Opcional* |

## 5. Comparativa antes vs. después

| Métrica | Antes (Línea base) | Después (Post-hardening) | Diferencia / Notas |
| :--- | :---: | :---: | :--- |
| **Lynis Hardening Index** | `60` | `65` | `+5` puntos tras aplicar controles |
| **Puertos TCP/UDP en escucha** | *Ver `ss_antes.txt`* | 1 socket UDP (`eth0:546` DHCPv6 link-local) | Verificado en `ss_despues.txt` |
| **Servicios `enabled`** | 35 unidades | 34 unidades | `-1` unidad tras deshabilitar servicios no usados |
| **Estado del firewall (UFW)** | Inactivo / no instalado | Activo (`deny incoming`, `allow outgoing`) | Verificado en `ufw_despues.txt` |
| **Integridad de evidencia (`SHA-256`)** | `hashes_antes.txt` | `hashes_despues.txt` | 4 archivos verificados (`lynis-report-despues.dat`, `ss_despues.txt`, `servicios_despues.txt`, `ufw_despues.txt`) |

## 6. Limitaciones, incidencias y lecciones aprendidas

- **Servicios conservados intencionalmente:** Se mantuvieron activos `NetworkManager.service`, `networking.service`, `ufw.service`, `virtualbox-guest-utils.service` y `systemd-timesyncd.service` para preservar conectividad, integración de la VM, filtrado de red y sincronización horaria para registros.
- **Permisos en evidencia de Lynis:** `/var/log/lynis-report.dat` se genera con permisos exclusivos de `root` (`-rw-r-----`), por lo que fue necesario usar `sudo` o ajustar permisos para leerlo o calcular su hash SHA-256 desde el usuario estándar.
- **Sintaxis en shell (`zsh`):** En `zsh`, escribir caracteres `<` o `>` literales en marcadores de ejemplo provoca error de parseo de redirección; conviene sustituir el marcador por el nombre real de la unidad.

## 7. Referencias

- **CIS Benchmarks** (Center for Internet Security) — Marco de referencia para endurecimiento de sistemas operativos Linux.
- Documentación oficial de **Lynis**, **UFW** y **systemd**.

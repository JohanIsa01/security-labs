# System Hardening Lab

Laboratorio práctico de endurecimiento básico y medición de superficie de ataque con enfoque de evidencia antes y después, tomando como referencia **CIS Benchmarks**.

## Entorno y alcance

- **Sistema auditado:** Kali Linux (`kali-rolling`, `amd64`) en máquina virtual de **VirtualBox**.
- **Herramientas:** `lynis`, `ss`, `systemctl`, `ufw`, `unattended-upgrades`, `sha256sum`.
- **Windows:** Marcado como **pendiente** al no disponer de una VM de Windows en el entorno actual.

## Resultados (Linux - Antes vs. Después)

| Métrica | Antes | Después | Notas |
| :--- | :---: | :---: | :--- |
| **Lynis Hardening Index** | `60` | `65` | `+5` puntos tras aplicar controles |
| **Servicios `enabled`** | `35` | `34` | Se deshabilitaron `ModemManager.service` y `pcscd.socket` |
| **Firewall (`ufw`)** | Inactivo / sin configurar | Activo | Política `deny (incoming)` y `allow (outgoing)` |
| **Actualizaciones automáticas** | No configuradas | Configuradas | `unattended-upgrades` habilitado |
| **Puertos / sockets en escucha** | *Ver `ss_antes.txt`* | 1 socket UDP (`eth0:546`) | DHCPv6 link-local en `ss_despues.txt` |

## Limitaciones y nota de privacidad

- **Limitaciones:** Algunas mejoras sugeridas por Lynis (como endurecimiento adicional de kernel/AppArmor o afinado profundo de parámetros del sistema) quedan como mejora futura; los sockets en escucha no muestran servicios innecesarios expuestos tras activar UFW.
- **Nota sobre reportes redactados:** Los archivos `.dat` de Lynis en `linux/evidencia/` están redactados para omitir datos sensibles del entorno real (usuario y referencias de red/ISP) antes de publicarse en el repositorio.

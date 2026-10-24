# Auditoría y Fortalecimiento de Red Wi-Fi Doméstica

## 1. Objetivo y Alcance
* **Objetivo:** Realizar una evaluación de seguridad y hardening de la infraestructura Wi-Fi residencial para identificar vulnerabilidades, malas configuraciones y servicios expuestos, aplicando remediaciones según estándares defensivos.
* **Entorno de Auditoría:** Estación de trabajo defensiva virtualizada corriendo **Kali Linux** en modo puente (*Bridged Adapter*), permitiendo visibilidad directa y escaneo en la subred local.
* **Declaración de Alcance:** Auditoría realizada exclusivamente sobre la red Wi-Fi de uso residencial propio (`192.168.0.1/24`), bajo autorización propia y restringida únicamente a dispositivos pertenecientes al auditor. Se excluyen pruebas de denegación de servicio (DoS) o explotación destructiva.
* **Fecha de Ejecución:** 23/10/2026
* **Dispositivo Central:** Router ARRIS / Model TG2482A

---

## 2. Herramientas Utilizadas
* **Sistema Operativo Auditor:** Kali Linux (Virtual Machine)
* **Escaneo de Red y Servicios:** Nmap (`nmap -sn`, `nmap -sV`)
* **Gestión de Red:** Panel de Administración del Router (GUI Web)

---

## 3. Metodología
La auditoría se desarrolló siguiendo 6 fases estructuradas desde la VM con Kali Linux:

1. **Fase 0 (Preparación):**
    Creación de carpeta principal y sus subcarpetas de evidencia y documentación
    [img01.png]

2. **Fase 1 (Inventario):** 
    Mapeo de activos conectados y conciliación entre el panel de administración del router y el descubrimiento ARP/IP con `sudo nmap -sn 192.168.0.0/24` desde Kali.
    [img02.png]
    [img03.png]

3. **Fase 2 (Revisión de Configuración):**  
    Se realizó una inspección detallada de los parámetros de seguridad y estado de la red en el panel de administración del router ARRIS TG2482A, documentando los siguientes puntos críticos:

    **- Credenciales de Administración:** Se verificó que el acceso al panel web utiliza las credenciales predeterminadas de fábrica, representando un riesgo crítico de acceso no autorizado.
    **- Cifrado Wi-Fi (Banda 2.4 GHz):** El SSID principal (`OZIEL_01`) opera bajo el protocolo seguro **WPA2-PSK (AES)**, evitando estándares obsoletos como TKIP.
    **- Red de Invitados:** Se encuentra deshabilitada, aunque mantenía configuraciones de UPnP y modos mixtos heredados
    **- Servicio UPnP:** Detectado como activo en los ajustes perimetrales, permitiendo la apertura automática de puertos
    **- Configuración del Firewall:** Se constató que el Firewall perimetral, la protección contra ataques DoS y el bloqueo de ping se encuentran habilitados, mientras que el bloqueo de paquetes IP fragmentados estaba inactivo
    **- Modo Inalámbrico:** Configurado en modo mixto (`B/G/N`), manteniendo compatibilidad con dispositivos antiguos pero con una superficie de modulación más amplia.

4. **Fase 3 (Análisis de Exposición):** 
    Se ejecutó un escaneo de detección de versiones de servicio (`sudo nmap -sV 192.168.0.1/24`) sobre la subred local para identificar la superficie de ataque de la infraestructura
    [img04.png]

    * **c Gateway (192.168.0.1 - ARRIS):** Se identificaron los servicios web de gestión `lighttpd` en los puertos `80/tcp` y `443/tcp`. Adicionalmente, se confirmó la exposición del servicio `MiniUPnP 1.9` en el puerto `5000/tcp`, lo que confirma la apertura dinámica de puertos sin filtrado previo.

    * **Endpoints Internos (192.168.0.2):** Se detectaron puertos de recursos compartidos de Windows `445/tcp (SMB)` y `135/tcp (RPC)` expuestos en la red local.

    * **Dispositivos Smart/IoT (192.168.0.13 - 192.168.0.15):** Exposición de puertos de transmisión de medios Google Cast (`8008/tcp`, `8009/tcp` - Ninja Sphere Chromecast driver
        [img05.png]
        [img06.png]

5. **Fase 4 (Informe de Hallazgos):** 
    Clasificación del riesgo mediante la matriz `Probabilidad × Impacto` y redacción de recomendaciones

    ### Criterio de Riesgo
    El riesgo se calcula como **Probabilidad × Impacto**:
    * **Alto:** Impacto severo en la confidencialidad/integridad o exposición directa a Internet sin autenticación sólida.
    * **Medio:** Configuración débil o servicio innecesario que incrementa la superficie de ataque local.
    * **Bajo:** Desviación de buenas prácticas con impacto directo limitado.

    | ID | Hallazgo | Riesgo | Evidencia | Recomendación | Estado |
    | :---: | :--- | :---: | :--- | :--- | :---: |
    | **SEC-01** | *[Credenciales de administración por defecto]* | **Alto** | `evidencias/img07.png` | Modificar el usuario y la contraseña de administración del router por una combinación robusta. | Remediado |
    | **SEC-02** | *[Servicio UPnP activo en el Router 5000/tcp] | **Medio** | `evidencias/fase3_nmap.txt` | Desactivar UPnP en el panel de administración para evitar la apertura no supervisada de puertos | Remediado |
    | **SEC-03** | *[Bloqueo de paquetes IP fragmentados inactivo en el Firewall]* | **Bajo** | `evidencias/fase3_nmap.txt` | Habilitar la casilla de bloqueo de paquetes fragmentados para mitigar vectores de evasión | Remediado |
    | **SEC-04** | *Servicios SMB/RPC expuestos en red local (192.168.0.2)* | **Medio** | `evidencias/fase3_nmap.txt` | Verificar la configuración del perfil de red en Windows (cambiar de Red Pública a Privada con Firewall activo) | Documentado |
    ---

6. **Fase 5 (Remediación y Verificación):** 
    Una vez documentados los riesgos en las fases previas, se procedió a aplicar las medidas correctivas directamente sobre la infraestructura del router ARRIS TG2482A y los equipos de la red local.

    ### 5.1. Acciones Correctivas Aplicadas
    1. **Endurecimiento de Credenciales (SEC-01):** Se modificó la contraseña predeterminada de acceso al panel de administración del router por una clave robusta y única.
    2. **Desactivación de UPnP (SEC-02):** Se deshabilitó el protocolo UPnP en el panel de configuración, cerrando formalmente el puerto `5000/tcp` (`MiniUPnP`) y eliminando la capacidad de apertura automática de puertos sin supervisión.
    3. **Endurecimiento del Firewall (SEC-03):** Se activó la directiva de bloqueo de paquetes IP fragmentados en el cortafuegos perimetral.

    ### 5.2. Verificación Post-Remediación (Before / After)
    Para comprobar la efectividad de las medidas, se ejecutó nuevamente el escaneo de puertos de control sobre la pasarela residencial (`192.168.0.1`) desde la máquina virtual:
    sudo nmap -sV 192.168.0.1 
        [img07.png]

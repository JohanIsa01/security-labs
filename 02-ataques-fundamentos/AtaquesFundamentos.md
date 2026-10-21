# Laboratorio: Reconocimiento básico en red propia

## Objetivo
Practicar técnicas básicas de reconocimiento de red usando Nmap, 
en mi propia red doméstica

## Entorno
- Atacante: Kali Linux sobre VirtualBox
- Red objetivo: red doméstica personal (autorizada, propia)

## Paso 1: Descubrimiento de hosts
Comando usado: `nmap -sn 192.168.0.0/24`
Resultado: Se encontró 12 dispositivos activos
![alt text](image-1.png)

## Paso 2: Escaneo de puertos
Comando usado: `nmap -sV 192.168.0.8`
Resultado: Se identificó un dispositivo activo con 5 puertos abiertos relevantes (995 puertos cerrados omitidos):
- **8008/tcp** - `open` - `http?`
- **8009/tcp** - `open` - `ssl/castv2` (Ninja Sphere Chromecast driver)
- **8010/tcp** - `open` - `ssl/castv2` (Ninja Sphere Chromecast driver)
- **8443/tcp** - `open` - `ssl/https-alt?`
- **9000/tcp** - `open` - `ssl/cslistener?`
- **Dirección MAC del objetivo:** `D2:F2:30:46:BD:61` (Unknown)
![alt text](image-2.png)

## Hallazgos y reflexión
- ¿Qué puertos estaban abiertos que no esperaba?
    Durante el escaneo al host objetivo (192.168.0.8), se detectaron 5 puertos Abiertos (open) que revelan servicios de transmisión multimedia e interfaces web:   
    **Puertos 8009/tcp y 8010/tcp (ssl/castv2):** Se identificaron firmas del protocolo Google Cast / Chromecast (Ninja Sphere Chromecast driver). Esto confirma que el dispositivo objetivo es muy probablemente un Smart TV, un dispositivo Chromecast o un equipo de transmisión multimedia en streaming   
    **Puertos 8008/tcp y 8443/tcp (http / https-alt):** Puertos web alternativos utilizados habitualmente para la gestión, emparejamiento o API del dispositivo multimedia.   
    **Puerto 9000/tcp (ssl/cslistener):** Servicio adicional en escucha que suele utilizarse para comunicación o control remoto de aplicaciones.   
    
    Aunque es normal que un dispositivo multimedia tenga estos servicios activos para funcionar dentro de la red, no esperaba encontrar tantos puertos de gestión o streaming expuestos simultáneamente sin autenticación estricta a nivel de red.   

- ¿Qué recomendaría cerrar o asegurar?
    1. **Segmentación de red (VLANs / Red de Invitados):** Aislar los dispositivos IoT y Smart TVs de la red principal donde se encuentran computadoras de trabajo o almacenamiento de datos confidenciales. De esta forma, si un atacante compromete el Smart TV (192.168.0.8), no podrá desviar tráfico hacia la máquina atacante (192.168.0.18) o el resto de los equipos.   
    2. **Desactivación de UPnP y servicios no utilizados:** Desactivar funciones de descubrimiento automático (UPnP) en el router si no son estrictamente necesarias, para evitar que dispositivos locales expongan estos puertos hacia Internet.
    3. **Actualización continua de firmware:** Mantener el sistema operativo del dispositivo objetivo actualizado para mitigar posibles vulnerabilidades conocidas en los servicios HTTP/CastV2.   
    4. **Filtrado por Firewall local o de Router:** Bloquear el acceso a puertos de administración interna (como el 8008, 8443 o 9000) desde direcciones IP que no requieran interactuar directamente con el dispositivo.   

- ¿Qué aprendí sobre cómo un atacante vería mi red?
    **Descubrimiento silencioso e invisibilidad:** Un atacante con acceso a la red local puede mapear en menos de 4 segundos toda la topología de la subred (192.168.0.0/24) e identificar la presencia de 11 dispositivos activos mediante un simple escaneo de descubrimiento (nmap -sn).   
    **Huella digital de dispositivos (Device Fingerprinting):** A través de las direcciones MAC e identidades detectadas (ej. Samsung Electronics, Amazon Technologies, Commscope), el atacante puede categorizar inmediatamente qué tipo de equipo es cada IP antes de lanzar cualquier vector de ataque explícito.   
    **Identificación de vectores de entrada:** El escaneo de versión (-sV) permite a un atacante identificar los servicios específicos que corren en los puertos expuestos. Si uno de estos servicios (como un servidor HTTP en puerto 8008) contiene un fallo o desbordamiento de memoria conocido, el atacante podría explotarlo para tomar el control del dispositivo o usarlo como pivote (pivoting) hacia toda la red interna.   

## Nota ética
Este laboratorio se realizó exclusivamente sobre mi propia red doméstica
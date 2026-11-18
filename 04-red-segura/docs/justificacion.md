# Justificación Técnica de Decisiones de Diseño

Cada decisión de arquitectura tomada en este proyecto responde directamente a una amenaza identificada en la Fase 1, siguiendo el principio de **defensa en profundidad** y **mínimo privilegio**.

## 1. Creación de Zona DMZ para el Servidor Web (Mitiga AM-02)
* **Decisión:** Ubicar el servidor web público en la `VLAN 30 (10.10.30.0/24)` detrás del firewall perimetral, completamente separado de la `VLAN 20` donde reside la base de datos clínica.
* **Justificación:** Al estar expuesto a Internet (puertos 80/443), el servidor web es el activo con mayor superficie de ataque. Si un atacante logra comprometerlo, las reglas de firewall prohíben cualquier conexión iniciada desde la `VLAN 30` hacia cualquier subred interna (`10.10.0.0/16`), conteniendo el incidente en el perímetro.

## 2. Aislamiento estricto de la Red de Invitados (Mitiga AM-01)
* **Decisión:** Asignar un SSID independiente mapeado a la `VLAN 40 (10.10.40.0/24)` con bloqueo hacia todo el espacio de direcciones privadas RFC 1918 y activación de *AP Client Isolation*.
* **Justificación:** En una clínica dental circulan decenas de dispositivos personales externos diariamente. Este diseño garantiza que los visitantes únicamente puedan resolver DNS y navegar por Internet (puertos 53, 80, 443), impidiendo que vean impresoras, computadoras de recepción o incluso otros dispositivos de pacientes conectados al mismo Wi-Fi.

## 3. Separación de Datos Críticos y Estaciones de Trabajo (Mitiga AM-03)
* **Decisión:** Separar los equipos de usuarios (`VLAN 10`) del servidor de historias clínicas (`VLAN 20`), permitiendo tráfico únicamente hacia los puertos estrictamente necesarios para la aplicación médica.
* **Justificación:** Si una estación de recepción se infecta con ransomware o malware, la segmentación evita el escaneo indiscriminado de red y reduce drásticamente la superficie de propagación lateral hacia los respaldos y servidores centrales.

## 4. Confinamiento de Dispositivos IoT / Cámaras IP (Mitiga AM-04)
* **Decisión:** Aislar las cámaras IP en la `VLAN 50 (10.10.50.0/24)` sin puerta de enlace hacia Internet.
* **Justificación:** Los dispositivos IoT suelen carecer de actualizaciones de seguridad frecuentes. Al bloquear su salida a Internet y su comunicación con otras VLANs, se evita que sean reclutados en botnets (como Mirai) o utilizados como puente hacia la red administrativa.

## 5. Plano de Gestión Dedicado (Mitiga AM-05)
* **Decisión:** Configurar una `VLAN 99 (10.10.99.0/24)` exclusiva para las interfaces administrativas de switches, firewall y AP, deshabilitando protocolos inseguros (Telnet/HTTP) en favor de SSHv2 y HTTPS.
* **Justificación:** Impide que cualquier usuario en la LAN de empleados o invitados pueda siquiera alcanzar la pantalla de inicio de sesión de los dispositivos críticos de infraestructura.

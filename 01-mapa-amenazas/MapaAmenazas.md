# MAPA DE AMENAZAS COMÚNES

**Autor:** Johan Isaias Peñaranda Manchego
**Contexto:** Práctica personal.
**Objetivo:** Documentar las amenazas de ciberseguridad más comunes, un ejemplo real de cada una y las medidas de mitigación asociadas.

---

## 1. PHISHING

Técnica de ingeniería social donde un atacante se hace pasar por una entidad confiable (banco, empresa, colega) para engañar a la víctima y que revele información sensible (contraseñas, datos bancarios) o ejecute una acción dañina (hacer clic en un enlace malicioso).

**Caso real:** EE.UU. se convierte en el principal objetivo de la campaña de phishing de RMM que abarca 46 países
**Fecha:** 03/Sept/2026
**Enlace:** [thehackernews.com](https://thehackernews.com/2026/09/us-becomes-top-target-in-rmm-phishing.html)

**¿Qué pasó?**
Se ha descubierto una gran campaña de phishing que afecta a 46 países, siendo Estados Unidos el más atacado con el 45% de los casos. Los atacantes engañan a las víctimas utilizando documentos falsos que parecen legítimos como cartas de impuestos, facturas, avisos del Seguro Social o de envíos de UPS y formularios de Adobe. Cuando la víctima cae en el engaño, termina instalando un software de gestión remota (RMM).

**¿Qué es el software RMM y por qué lo usan?**
El software RMM es una herramienta legítima que usan los técnicos de sistemas para controlar computadoras a distancia. Los ciberdelincuentes usan estos programas porque los antivirus no suelen bloquearlos, permitiéndoles tomar el control del equipo sin levantar sospechas.

**¿Por qué es tan difícil detectar?**
- Los atacantes cambian sus páginas web, enlaces y servidores casi a diario (utilizan servicios como Vercel, GitHub Pages, Amazon S3, Dropbox, etc.). El 94% de sus enlaces solo dura un día activo.
- Al no usar un virus tradicional, sino programas legales y sitios conocidos, los sistemas de seguridad no se activan automáticamente.

**Sectores más atacados:**
- Educación
- Tecnología
- Gobierno
- Banca y Finanzas
- Manufactura

**¿Cómo se conectaron los ataques y cómo protegerse?**
A pesar de que cambian de páginas web todos los días, la empresa de ciberseguridad ANY.RUN descubrió que los atacantes reutilizan ciertas "huellas digitales" internas en sus páginas (archivos de fuentes de texto específicos como font1.woff2, imágenes de iconos de Word y estructuras de archivos .zip).

**Mitigación:**
- No confiar solo en el antivirus o en bloquear sitios web, pues las páginas cambian a diario; bloquear un dominio no sirve de mucho.
- Detectar cuándo se instala un software de control remoto sin autorización.
- Controlar los correos electrónicos teniendo especial cuidado con archivos adjuntos protegidos con contraseña y capacitar a los empleados para no caer en trampas de phishing.
- Monitorear qué hacen los navegadores y programas en segundo plano para identificar la amenaza a tiempo.

---

## 2. MALWARE

Término general para cualquier software diseñado para dañar, espiar o tomar control no autorizado de un sistema. Incluye virus, troyanos, spyware y gusanos.

**Caso real:** Ransomware en el sector salud - fuga masiva de datos
**Fecha:** 20/Ago/2026
**Enlace:** [yanapti.com](https://yanapti.com/2026/ransomware-en-el-sector-salud-fuga-masiva-de-datos/)

**¿Qué pasó?**
DentaQuest (administradora de servicios dentales y oftalmológicos en EE. UU.) sufrió un ciberataque en mayo de 2026 que expuso los datos personales y médicos de 15 millones de personas, siendo esta la mayor filtración de datos de salud en 2026. Aunque los atacantes dijeron haber robado datos de 2.6 millones de personas, la investigación oficial reveló que la cifra real era casi seis veces mayor. Esto demuestra que la verdadera magnitud de un ataque la determina un peritaje forense y no lo que afirman los criminales.

**La amenaza — modelo "doble extorsión":**
Los atacantes no solo bloquean o cifran la información para pedir un rescate, sino que roban los datos antes de bloquearlos y amenazan con publicarlos.

**Impacto para entidades reguladas (financieras y de salud):**
- **Financiero:** Gastos de respuesta, multas e indemnizaciones.
- **Reputacional:** Pérdida de la confianza de clientes o pacientes.
- **Normativo:** Sanciones por incumplir reglamentos de protección de datos.
- **Operativo:** Interrupción del servicio.
- **Legal:** Demandas por mal manejo de datos sensibles.

**Mitigación:**
- Cifrar datos en tránsito y en reposo para que, si son robados, no puedan ser leídos.
- Usar autenticación de doble factor y limitar permisos para que el atacante no pueda moverse libremente por toda la red.
- Contar con herramientas para reaccionar a tiempo y recopilar pruebas válidas bajo normas internacionales.
- Construir sistemas incluyendo la seguridad desde el primer día, anticipándose a las tácticas de los atacantes en lugar de solo llenar una lista de requisitos.

---

## 3. RANSOMWARE

Tipo específico de malware que cifra los archivos de la víctima y exige un pago para restaurar el acceso.

**Caso real:** Warlock aprovecha las fallas de SharePoint para deshabilitar herramientas de seguridad e implementar ransomware
**Fecha:** 03/Oct/2026
**Enlace:** [thehackernews.com](https://thehackernews.com/2026/10/warlock-exploits-sharepoint-flaws-to.html)

**¿Qué pasó?**
El grupo de ciberdelincuentes vinculado a China conocido como Warlock está realizando ciberataques contra organizaciones en países de habla hispana y portuguesa (en Europa, África y América Latina) afectando sectores como empresas de agua, proveedores de telecomunicaciones, organismos gubernamentales regionales y universidades.

**¿Cómo ejecutan el ataque?**
- **Entrada inicial — vulnerabilidades en SharePoint:** Aprovechan fallos de seguridad no parcheados en servidores Microsoft SharePoint locales para instalar webshells o puertas traseras, robando claves internas para ejecutar código malicioso dentro del servidor.
- **Desactivación del antivirus — técnica Bring Your Own Vulnerable Driver (BYOVD):** Instalan un controlador legítimo pero vulnerable (K7RKScan.sys) para desarmar y apagar los programas de seguridad y antivirus de las máquinas atacadas.
- **Uso de herramientas legítimas para pasar desapercibidos:**
  - En Visual Studio Code abusan de su función de túnel remota para conectarse a las computadoras infectadas sin levantar sospechas.
  - En los servicios en la nube descargan malware desde plataformas públicas de almacenamiento como catbox.moe y wasabisys.com.
- **Infección masiva y ransomware:** Aprovechan la carpeta compartida del dominio de la red (SYSVOL) para distribuir el virus a decenas de computadoras al mismo tiempo mediante la replicación automática de Windows, desplegando finalmente el ransomware para secuestrar los sistemas.

**Mitigación:**
- Parchear SharePoint de inmediato, cuya principal vía de entrada son servidores Microsoft SharePoint sin actualizar o con parches pendientes.
- Supervisar el uso inusual de túneles remotos en Visual Studio Code o programas como Velociraptor.
- Implementar políticas de mitigación para evitar la técnica BYOVD que deshabilita las soluciones antivirus bloqueando controladores vulnerables conocidos.

---

## 4. ATAQUE DE DENEGACIÓN DE SERVICIO DISTRIBUIDO (DDoS)

Ataque que busca saturar un sistema, servidor o red con tráfico excesivo, dejándolo inaccesible para usuarios legítimos usando múltiples equipos comprometidos (botnet) simultáneamente.

**Caso real:** Red Unitel denuncia ataque informático
**Fecha:** 16/Ago/2024
**Enlace:** [lapatria.bo](https://lapatria.bo/actualidad/red-unitel-denuncia-ataque-informatico/)

**¿Qué pasó?**
La cadena de televisión boliviana Red Unitel denunció que su sitio web (Unitel.bo) sufrió un ciberataque la madrugada del viernes 16 de agosto de 2024, el cual dejó fuera de servicio su plataforma digital durante hora y media (desde las 5:30 a.m.).

**Origen técnico:**
Se identificó que el ataque fue ejecutado utilizando al menos 5.300 direcciones IP desconocidas.

**Contexto:**
El ataque ocurrió en un periodo donde Unitel venía siendo blanco de críticas y mensajes en redes sociales debido a su cobertura periodística sobre protestas y conflictos sociales contra medidas del gobierno.

**Estado actual:**
El equipo técnico del medio logró mitigar el incidente y restaurar el servicio en su página web de manera habitual.

**Mitigación:**
- Uso de servicios de mitigación DDoS (como CDNs con protección integrada).
- Configuración de límites de tasa (rate limiting) en servidores.
- Monitoreo de tráfico anómalo en tiempo real.

---

## 5. ATAQUES DE FUERZA BRUTA

Intento sistemático de adivinar credenciales (usuario/contraseña) probando múltiples combinaciones hasta encontrar la correcta.

**Caso real:** ASFI reconoce "ataque de fuerza bruta" a tarjetas de débito del Mercantil Santa Cruz
**Fecha:** 17/Dic/2024
**Enlace:** [rtpbolivia.com.bo](https://rtpbolivia.com.bo/economia/asfi-reconoce-ataque-de-fuerza-bruta-a-tarjetas-de-debito-del-mercantil-santa-cruz/)

**¿Qué pasó?**
Entre abril y mayo de 2024, clientes del Banco Mercantil Santa Cruz en Bolivia reportaron cobros y consumos no autorizados en sus tarjetas de débito por compras en plataformas de internet en el exterior. Un cliente registró hasta 48 compras no autorizadas (más de 6.700 bolivianos). La afectación movilizó a más de 1.400 personas afectadas en Santa Cruz, La Paz, Cochabamba y Tarija. El BMSC indicó que el ataque afectó al 0,0069% del total de sus tarjetas y procedió a la devolución íntegra del dinero a todos los clientes perjudicados.

**Origen técnico:**
La Autoridad de Supervisión del Sistema Financiero (ASFI) confirmó que los cobros se debieron a un ataque de fuerza bruta a través de comercios fraudulentos, en la que los atacantes utilizaron programas automatizados para probar combinaciones masivas de números de tarjetas hasta dar con datos válidos, abusando de tiendas en línea sin medidas de seguridad. Expertos y afectados no descartan que la información de los lotes de tarjetas (números, fechas de vencimiento y códigos CVV) haya sido filtrada internamente o comercializada en la Deep Web y grupos de Telegram.

**Diagnóstico del sector financiero y ciberseguridad en Bolivia:**
- Expertos señalan que en Bolivia existe una cultura de hermetismo institucional por temor al daño reputacional, a diferencia de otros países donde los bancos informan abiertamente sobre ciberataques.
- Las estafas de phishing (engaño al usuario) siguen siendo los ataques más exitosos en el sistema financiero local.
- Según el Global Cybersecurity Index 2024, Bolivia se ubica en un nivel "evolutivo" bajo (Grupo 4, con puntajes de 20 a 55 sobre 100), mostrando la necesidad de fortalecer sus infraestructuras digitales y la concienciación de los usuarios.

**Mitigación:**
Tras el incidente, el BMSC implementó ajustes inmediatos en sus plataformas:
- Cerró las compras por internet y el sistema de tarjetas por casi una semana para actualizar sus protocolos de seguridad.
- Eliminó la habilitación automática de tarjetas para compras electrónicas y bloqueó comercios en línea sospechosos.
- Implementó alertas vía SMS y llamadas telefónicas para confirmar transacciones sospechosas con el cliente.

---

## 6. INGENIERÍA SOCIAL

Manipulación psicológica para que una persona realice acciones o divulgue información confidencial, sin necesariamente usar un medio digital (puede ser una llamada telefónica, una visita presencial, etc.).

**Caso real:** Bolivia registra 16.821 denuncias de fraude digital en 2026
**Fecha:** 18/Jun/2026
**Enlace:** [lapatria.bo](https://lapatria.bo/actualidad/seguridad/fraude-digital-bolivia-mil-denuncias/)

**¿Qué pasó?**
Entre el 1 de enero y el 17 de julio de 2026, la plataforma estatal "Bloquea la Estafa" registró un total de 16.821 denuncias por estafas digitales.
- **Equipos bloqueados (IMEI):** 13.516 celulares inhabilitados definitivamente.
- **Líneas cortadas:** 10.846 líneas telefónicas dadas de baja.
- **Estado de las denuncias:** 9.374 declaradas procedentes, 7.004 improcedentes, 443 en proceso de revisión.

**Operadores más afectados:**
- Telecel (Tigo): 67%
- Entel: 15%
- Nuevatel (Viva): 12%
- Operadores internacionales: 6%

**Origen técnico:**
Suplantación de identidad bajo la "supuesta asistencia del operador". Los estafadores se hacen pasar por personal técnico o de atención al cliente para engañar a las víctimas y robarles códigos de verificación, datos personales o contraseñas de sus cuentas. El eje central de Bolivia concentra la mayor cantidad de víctimas, abarcando a La Paz, Santa Cruz y Cochabamba.

**Mitigación — Recomendación de la ATT:**
La Autoridad de Regulación y Fiscalización de Telecomunicaciones y Transportes (ATT) reitera que ninguna empresa telefónica solicita contraseñas o códigos de verificación por llamada o mensaje, e insta a la población a denunciar cualquier intento sospechoso mediante la plataforma Bloquea la Estafa.

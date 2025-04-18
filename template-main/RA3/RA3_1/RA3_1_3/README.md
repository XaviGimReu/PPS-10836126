# 🐝 Práctica 3: OWASP ModSecurity CRS en Apache

## 📌 Introducción a OWASP

El **OWASP ModSecurity Core Rule Set (CRS)** es un conjunto de reglas preconfiguradas que fortalecen la seguridad de las aplicaciones web contra amenazas comunes, como:

- 🚫 **Inyección SQL (SQLi)**
- 🚫 **Cross-Site Scripting (XSS)**
- 🚫 **Ejecución remota de código (RCE)**
- 🚫 **Path traversal**
- 🚫 **Inyección de comandos (Command Injection)**

Este conjunto de reglas permite a los administradores de servidores proteger sus aplicaciones web de manera eficiente sin necesidad de definir reglas personalizadas desde cero.

---

## ⚙️ **Instalación y Configuración de OWASP ModSecurity CRS**

### 🔹 Instalación de ModSecurity y OWASP CRS

1️⃣ Instalar el módulo de ModSecurity para Apache:
```bash
apt update && apt install -y libapache2-mod-security2
```

2️⃣ Clonar el repositorio oficial de OWASP ModSecurity CRS:
```bash
git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git
```

3️⃣ Mover el archivo de configuración base:
```bash
mv owasp-modsecurity-crs/crs-setup.conf.example /etc/modsecurity/crs-setup.conf
```

4️⃣ Mover las reglas al directorio de configuración de ModSecurity:
```bash
mv owasp-modsecurity-crs/rules/ /etc/modsecurity
```
Si encuentras algún error, crea la carpeta y copia las reglas manualmente:
```bash
mkdir /etc/modsecurity/rules
cd owasp-modsecurity-crs/rules
cp *.* /etc/modsecurity/rules
```

✅ Ahora las reglas OWASP están instaladas en nuestro servidor.

---

### 🔹 Configuración de Apache para cargar OWASP CRS

1️⃣ Editar la configuración de ModSecurity en Apache:
```bash
nano /etc/apache2/mods-enabled/security2.conf
```
Añadir la siguiente configuración para cargar las reglas de OWASP CRS:
```apache
<IfModule security2_module>
    # Directorio donde ModSecurity almacena datos persistentes
    SecDataDir /var/cache/modsecurity

    # Activar ModSecurity
    SecRuleEngine On

    # Cargar reglas OWASP CRS
    IncludeOptional /etc/modsecurity/*.conf
    Include /etc/modsecurity/rules/*.conf
</IfModule>
```

📸 **Captura de configuración de security2.conf:**


![security2.conf](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/OWASP/1.png)

📌 **Nota:** Esta configuración permite que ModSecurity aplique las reglas OWASP CRS en todas las solicitudes HTTP que reciba Apache.

---

### 🔹 Configuración de reglas personalizadas en el Host Virtual
Para probar que el firewall está funcionando correctamente, agregaremos una regla personalizada en la configuración del host virtual de Apache.

1️⃣ Editar el archivo del host virtual de Apache:
```bash
nano /etc/apache2/sites-enabled/default-ssl.conf
```

2️⃣ Agregar la siguiente regla dentro del bloque `<VirtualHost>`:
```apache
# Activar ModSecurity en este host
SecRuleEngine On

# Bloquear cualquier parámetro que contenga "test"
SecRule ARGS:testparam "@contains test" "id:1234,deny,status:403,msg:'Cazado por Ciberseguridad'"
```

📸 **Captura de configuración del VirtualHost:**


![VirtualHost](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/OWASP/2.png)

✅ Esta configuración bloqueará cualquier solicitud que contenga `testparam=test`.


### 🔄 Reiniciar Apache para aplicar los cambios
```bash
service apache2 reload
```

---

## 🔍 **Prueba de OWASP ModSecurity CRS en Apache**

### 🔹 Simulación de ataques reales

**1️⃣ Intento de ejecución remota de comandos:**
```bash
https://localhost:8080/index.html?exec=/bin/bash
```
📸 **Ejemplo de ataque bloqueado:**


![Command Injection](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/OWASP/3.png)

**2️⃣ Intento de path traversal:**
```bash
https://localhost:8080/index.html?exec=/../../"
```
📸 **Ejemplo de path traversal bloqueado:**


![Path Traversal](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/OWASP/4.png)

✅ **Las reglas OWASP CRS han detectado y bloqueado ambos intentos de ataque.**

---

## 📬 Referencias
**[RA3_1_1 (CSP)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_1)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_2(WAF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_2)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_4 (Ataques DDoS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_4)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_5 (Certificado digital)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_5)**

---

# 🧱🔥 Práctica 2: Web Application Firewall (WAF)

## 📌 Introducción a WAF
Un **firewall de aplicaciones web (WAF)** es un mecanismo de seguridad que supervisa, filtra o bloquea el tráfico HTTP hacia y desde una aplicación web. A diferencia de los firewalls tradicionales, un WAF puede analizar el contenido de las solicitudes y respuestas HTTP, protegiendo contra amenazas como:

- 🚫 **Inyección SQL (SQLi)**
- 🚫 **Cross-Site Scripting (XSS)**
- 🚫 **Falsificación de petición de sitios cruzados (CSRF)**

### 📖 Historia y desarrollo
En 2002, se creó **ModSecurity**, un proyecto de código abierto que facilitó el uso de WAFs. Posteriormente, en 2003, la **Lista Top 10 de OWASP** estandarizó los principales riesgos de seguridad en aplicaciones web, convirtiéndose en una referencia en la industria.

---

## ⚙️ **Configuración de ModSecurity en Apache**

### 🔹 Instalación de ModSecurity
Para instalar ModSecurity en Apache, ejecute el siguiente comando:
```bash
apt update && apt install -y libapache2-mod-security2
```

Luego, copie la configuración recomendada:
```bash
cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
```

### 🔹 Habilitar ModSecurity en Apache
Edite el archivo de configuración de ModSecurity:
```bash
nano /etc/modsecurity/modsecurity.conf
```
Ubique la línea:
```apache
SecRuleEngine DetectionOnly
```
Y cámbiela a:
```apache
SecRuleEngine On
```

📸 **Captura de la configuración de `modsecurity2.conf`:**


![modsecurity](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/Web%20Application%20Firewall%20(WAF)/1.png)

✅ Esto activará ModSecurity para analizar y bloquear tráfico malicioso.


### 🔹 Habilitar ModSecurity en la configuración de Apache
Edite el archivo de configuración de Apache:
```bash
nano /etc/apache2/apache2.conf
```
Añada lo siguiente:
```apache
<IfModule security2_module>
    SecRuleEngine On
</IfModule>
```

📸 **Captura de la configuración de `apache2.conf`:**


![apache2.conf](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/Web%20Application%20Firewall%20(WAF)/2.png)

✅ Esto asegurará que ModSecurity esté activado cada vez que Apache se inicie.

### 🔄 Reiniciar Apache
Para aplicar los cambios, reinicie Apache:
```bash
service apache2 reload
```

---

## 🔍 **Prueba de ModSecurity en Apache**
Para comprobar que ModSecurity está funcionando correctamente, copie el siguiente archivo `post.php` en el directorio raíz del servidor Apache:
```php
<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    echo "Datos recibidos: " . htmlspecialchars($_POST['data']);
}
?>
<form method="POST">
    <input type="text" name="data">
    <input type="submit" value="Enviar">
</form>
```

### 🔹 Intento de XSS
Si intentamos enviar un payload malicioso como:
```html
<script>alert(1)</script>
```

📸 **Captura de la prueba XSS:**


![XSS](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/Web%20Application%20Firewall%20(WAF)/3.png)

❌ ModSecurity bloqueará la solicitud y devolverá un error **403 Forbidden**.

### 🔹 WAF en acción
Al inspeccionar las cabeceras HTTP en la herramienta de desarrolladores del navegador, podemos ver que la solicitud fue bloqueada con un código de estado **403 Forbidden**.

📸 **Captura de la inspección del bloqueo XSS:**


![Bloqueo](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/Web%20Application%20Firewall%20(WAF)/4.png)

✅ Esto confirma que **ModSecurity está protegiendo nuestra aplicación web de ataques XSS.**

---

## 📬 Referencias
**[RA3_1_1 (CSP)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_1)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_3 (OWASP)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_3)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_4 (Ataques DDoS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_4)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_5 (Certificado digital)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_5)**

---

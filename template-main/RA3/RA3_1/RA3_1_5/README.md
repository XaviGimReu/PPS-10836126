# 🔐 Configuración de un Certificado Digital en Apache

## 📌 Introducción a los Certificados Digitales

Un **certificado digital** permite cifrar las comunicaciones entre el servidor y los clientes mediante SSL/TLS, garantizando la confidencialidad y autenticidad de los datos transmitidos. En esta práctica, configuraremos un certificado autofirmado en Apache.

Aunque un **certificado autofirmado** no cuenta con la validación de una Autoridad de Certificación (CA), es útil para entornos internos, pruebas o intranets donde el cifrado es necesario.

---

## ⚙️ Instalación y Configuración del Certificado en Apache

### 🔹 1. Habilitar el módulo SSL en Apache

Para habilitar el soporte para SSL en Apache, ejecuta:

```bash
a2enmod ssl
```

Luego, reiniciamos el servicio para aplicar los cambios:

```bash
service apache2 reload
```

✅ Ahora, nuestro servidor Apache está listo para manejar conexiones seguras.

---

### 🔹 2. Generación de un Certificado SSL Autofirmado

1️⃣ Creamos un directorio para almacenar el certificado:

```bash
mkdir /etc/apache2/ssl
```

2️⃣ Genera un certificado autofirmado con OpenSSL:

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt
```

#### 📌 Explicación de los parámetros:

- `-x509` → Genera un certificado autofirmado.
- `-nodes` → No protege la clave con una contraseña.
- `-days 365` → Validez de 1 año.
- `-newkey rsa:2048` → Genera una clave RSA de 2048 bits.
- `-keyout` → Ubicación de la clave privada.
- `-out` → Ubicación del certificado generado.

Durante el proceso, se solicitará información como el país, estado, ciudad y el Common Name (CN), donde debes ingresar el dominio del servidor:

```apache
Country Name (2 letter code) [AU]:ES
State or Province Name (full name) [Some-State]:Castellon
Locality Name (eg, city) []:Castellon de la Plana
Organization Name (eg, company) []:Midominioseguro
Common Name (e.g. server FQDN or YOUR name) []:www.midominioseguro.com
Email Address []:
```
📸 **Ejemplo del proceso de generación:**

![creacion certificado](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/8.%20Certificado.png)

✅ El certificado y la clave privada se almacenarán en `/etc/apache2/ssl/`.

---

### 3️⃣ Configurar Apache para Usar SSL

Editamos la configuración del VirtualHost SSL:

```bash
nano /etc/apache2/sites-available/default-ssl.conf
```

Buscamos y modificamos las siguientes líneas:

```apache
<IfModule mod_ssl.c>
    <VirtualHost _default_:443>
        ServerAdmin admin@midominioseguro.com
        ServerName www.midominioseguro.com
        DocumentRoot /var/www/html

        SSLEngine on
        SSLCertificateFile /etc/apache2/ssl/apache.crt
        SSLCertificateKeyFile /etc/apache2/ssl/apache.key

        <FilesMatch "\.(cgi|shtml|phtml|php)$">
            SSLOptions +StdEnvVars
        </FilesMatch>

        <Directory /usr/lib/cgi-bin>
            SSLOptions +StdEnvVars
        </Directory>
    </VirtualHost>
</IfModule>
```
📸 **Ejemplo del archivo de configuración:**

![configuracion certificado](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/9.%20Certificado-2.png)

✅ Ahora, nuestro servidor Apache está configurado para manejar conexiones HTTPS con el certificado autofirmado.

---

### 4️⃣ Configurar `/etc/hosts` para Resolución Local

Para poder acceder al dominio local con el certificado SSL, agregamos el siguiente registro en `/etc/hosts`:

```bash
nano /etc/hosts
```

Y añadimos la línea:

```bash
172.17.0.2   www.midominioseguro.com
```

📸 **Ejemplo del archivo `/etc/hosts`:**

![etc/hosts](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/10.%20etc_hosts.png)

---

### 5️⃣ Activar el VirtualHost SSL y Reiniciar Apache

Activamos la configuración SSL en Apache:

```bash
a2ensite default-ssl.conf
```

Reiniciamos Apache para aplicar los cambios:

```bash
service apache2 reload
```

✅ Apache ahora sirve contenido a través de HTTPS.

---

## 🔍 Prueba del Certificado en el Navegador

Abrimos un navegador y accedemos a nuestro dominio:

```
https://www.midominioseguro.com
```

Como el certificado es autofirmado, el navegador mostrará una advertencia. Debemos aceptar la excepción de seguridad para continuar.

📸 **Ejemplo de acceso seguro en el navegador:**

![acceso seguro](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/Cerficados/1.png)


✅ Ahora, nuestra página se servirá a través de HTTPS con cifrado SSL.

---

## 📜 Verificación del Certificado

Para visualizar la información del certificado en el navegador, haz clic en el **candado** de la barra de direcciones y selecciona **Ver certificado**.

📸 **Especificaciones del Certificado: Detalles Certificado**

![certificado](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/Cerficados/2.png)

✅ Ahora tenemos un **servidor Apache con HTTPS habilitado** mediante un certificado SSL auto-firmado.

---

## 📬 Referencias

**[RA3_1_1 (CSP)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_1)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_2 (WAF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_2)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_3 (OWASP)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_3)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_4 (Ataques DDoS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_4)**


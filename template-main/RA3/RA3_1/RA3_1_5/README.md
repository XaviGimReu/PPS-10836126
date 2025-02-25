# Configuración de un Certificado Digital en Apache

## Introducción

Un certificado digital permite cifrar las comunicaciones entre un cliente y un servidor, garantizando la privacidad de los datos transmitidos. En esta práctica, configuraremos un certificado SSL autofirmado en Apache, útil para entornos internos, pruebas o intranets.

Aunque un certificado autofirmado no es validado por una autoridad de certificación (CA), cumple su función al proporcionar cifrado SSL/TLS para asegurar la transferencia de información.

---

## Instalación y Configuración del Certificado SSL

### 1️⃣ Habilitar el módulo SSL en Apache

Apache tiene soporte para SSL/TLS, pero debemos habilitarlo con el siguiente comando:

```bash
sudo a2enmod ssl
```

Luego, reiniciamos el servicio para aplicar los cambios:

```bash
sudo service apache2 restart
```

✅ Ahora, nuestro servidor Apache está listo para manejar conexiones seguras.

---

### 2️⃣ Generar un Certificado SSL Autofirmado

Creamos un directorio para almacenar el certificado:

```bash
sudo mkdir /etc/apache2/ssl
```

Ahora, generamos la clave privada y el certificado con OpenSSL:

```bash
sudo openssl req -x509 -nodes -days 365 \
-newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt
```

#### Explicación de los parámetros:

- `-x509` → Genera un certificado autofirmado.
- `-nodes` → No protege la clave con una contraseña.
- `-days 365` → Validez de 1 año.
- `-newkey rsa:2048` → Genera una clave RSA de 2048 bits.
- `-keyout` → Ubicación de la clave privada.
- `-out` → Ubicación del certificado generado.

✅ El certificado y la clave privada se almacenarán en `/etc/apache2/ssl/`.

---

### 3️⃣ Configurar Apache para Usar SSL

Editamos la configuración del VirtualHost SSL:

```bash
sudo nano /etc/apache2/sites-available/default-ssl.conf
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

✅ Ahora, nuestro servidor Apache está configurado para manejar conexiones HTTPS con el certificado autofirmado.

---

### 4️⃣ Configurar `/etc/hosts` para Resolución Local

Para poder acceder al dominio local con el certificado SSL, agregamos el siguiente registro en `/etc/hosts`:

```bash
sudo nano /etc/hosts
```

Y añadimos la línea:

```bash
172.17.0.2   www.midominioseguro.com
```

---

### 5️⃣ Activar el VirtualHost SSL y Reiniciar Apache

Activamos la configuración SSL en Apache:

```bash
sudo a2ensite default-ssl.conf
```

Reiniciamos Apache para aplicar los cambios:

```bash
sudo service apache2 restart
```

✅ Apache ahora sirve contenido a través de HTTPS.

---

## 🔍 Prueba del Certificado en el Navegador

Abrimos un navegador y accedemos a nuestro dominio:

```
https://www.midominioseguro.com
```

Como el certificado es autofirmado, el navegador mostrará una advertencia. Debemos aceptar la excepción de seguridad para continuar.

✅ Ahora, nuestra página se servirá a través de HTTPS con cifrado SSL.

---

## 🚀 Opcional: Redirigir HTTP a HTTPS

Para forzar a que todas las conexiones sean seguras, agregamos esta configuración en el VirtualHost HTTP (`/etc/apache2/sites-available/000-default.conf`):

```apache
<VirtualHost *:80>
    ServerName www.midominioseguro.com
    Redirect / https://www.midominioseguro.com/
</VirtualHost>
```

Si queremos hacer la redirección permanente, usamos:

```apache
Redirect permanent / https://www.midominioseguro.com/
```

✅ Con esto, cualquier usuario que intente acceder a `http://www.midominioseguro.com` será redirigido automáticamente a HTTPS.

---

## 📬 Referencias

- RA3_1_1 (CSP)
- RA3_1_2 (WAF)
- RA3_1_3 (OWASP)
- RA3_1_4 (Ataques DDoS)

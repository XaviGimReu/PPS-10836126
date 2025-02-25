# Práctica 1: CSP

## 📌 Introducción a CSP
La **Política de Seguridad de Contenidos (CSP)** es una capa de seguridad adicional que ayuda a prevenir ataques como **Cross-Site Scripting (XSS)** y otros ataques de inyección de código malicioso. CSP restringe las fuentes desde donde se pueden cargar ciertos tipos de contenido en un sitio web, mejorando así la seguridad del servidor y del usuario final.

Al implementar CSP en un servidor Apache, se puede reducir el riesgo de ejecución de scripts maliciosos, asegurando que solo se carguen recursos confiables. A continuación, se detallan las configuraciones necesarias para aplicar esta política junto con otras medidas de seguridad.

---

## 🏗️ **Práctica CSP**
### 📌 Configurar la instalación de Apache para:

### 🔹 Deshabilitar el módulo `autoindex`
Este módulo permite la generación automática de listados de directorios en caso de que no exista un archivo `index.html` o `index.php`. Para desactivarlo, ejecute:
```bash
sudo a2dismod autoindex
```
✅ Esto previene la exposición accidental de archivos y directorios sensibles.

### 🔹 Configurar la cabecera **HSTS**
HSTS **(HTTP Strict Transport Security)** es una política de seguridad que obliga a los navegadores a usar HTTPS para comunicarse con el servidor.

Para habilitarlo en Apache, primero active el módulo `headers`:
```bash
sudo a2enmod headers
sudo systemctl restart apache2
```
Luego, agregue la siguiente línea en el archivo de configuración del host virtual:
```apache
<VirtualHost *:443>
    ...
    Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains"
    ...
</VirtualHost>
```
✅ Esto obliga a los navegadores a usar conexiones seguras durante **2 años**.

### 🔹 Configurar la cabecera **CSP**
Para mejorar la seguridad contra ataques XSS y evitar la ejecución de scripts no confiables, agregue la siguiente directiva en la configuración de Apache:
```apache
Header set Content-Security-Policy "default-src 'self'; img-src *; media-src media1.com media2.com; script-src userscripts.example.com"
```
✅ Este ejemplo establece que:
- Todo el contenido provenga del mismo origen (`'self'`).
- Las imágenes pueden cargarse desde cualquier fuente (`img-src *`).
- Los archivos de medios solo se permiten desde `media1.com` y `media2.com`.
- Los scripts solo pueden ejecutarse desde `userscripts.example.com`.

---

## 🔨 **Crear un Dockerfile con esta configuración**
Para automatizar la implementación de estas configuraciones en un contenedor Docker, cree un archivo `Dockerfile` con el siguiente contenido:

```dockerfile
FROM httpd:2.4

# Copiar archivos de configuración personalizados
COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./my-httpd-vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf

# Habilitar módulos y configurar seguridad
RUN sed -i '/#LoadModule headers_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    echo 'Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains"' >> /usr/local/apache2/conf/httpd.conf && \
    echo 'Header set Content-Security-Policy "default-src \'self\'; img-src *; media-src media1.com media2.com; script-src userscripts.example.com"' >> /usr/local/apache2/conf/httpd.conf
```

### 🚀 **Construir y ejecutar el contenedor Docker**
1️⃣ **Construir la imagen Docker:**
```bash
docker build -t hardenowasp .
```

2️⃣ **Ejecutar el contenedor con los puertos adecuados:**
```bash
docker run --detach --rm -p 8080:80 -p 8081:443 --name="hardenowasp" hardenowasp
```
✅ Esto inicia un servidor Apache endurecido con **HSTS y CSP activados.**

---

## 📬 Contacto
📧 Para dudas o consultas, contactar con el equipo docente a través de `@alu.edu.gva.es` o mediante **GitHub Issues** en el repositorio de la práctica. 🚀


# 🔒 Práctica 1: CSP

## 📌 Introducción a CSP
La **Política de Seguridad de Contenidos (CSP)** es una capa de seguridad adicional que ayuda a prevenir ataques como **Cross-Site Scripting (XSS)** y otros ataques de inyección de código malicioso. CSP restringe las fuentes desde donde se pueden cargar ciertos tipos de contenido en un sitio web, mejorando así la seguridad del servidor y del usuario final.

Al implementar CSP en un servidor Apache, se puede reducir el riesgo de ejecución de scripts maliciosos, asegurando que solo se carguen recursos confiables. A continuación, se detallan las configuraciones necesarias para aplicar esta política junto con otras medidas de seguridad.

---

## 🏗️ **Configuración de Apache**
En este apartado se realizarán una serie de configuraciones previas en el servicio Apache para posiblitar la posterior implementación de CSP.

### 🔹 Deshabilitar el módulo `autoindex`
Este módulo permite la generación automática de listados de directorios en caso de que no exista un archivo `index.html` o `index.php`. Para desactivarlo, ejecute:
```bash
sudo a2dismod autoindex
```
![autoindex](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/3.%20deshabilitar_autoindex.png)

✅ Esto previene la exposición accidental de archivos y directorios sensibles.

### 🔹 Ocultar la información del servidor en las cabeceras HTTP
Por defecto, Apache muestra información sobre su versión y sistema operativo en las respuestas HTTP. Esta información puede ser utilizada por atacantes para identificar vulnerabilidades específicas.

#### 🔍 Verificar la información expuesta
Para comprobar qué información está siendo expuesta por Apache, ejecute:
```bash
curl --head localhost
```
![curl](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/6.%20eliminaci%C3%B3n_cabeceras-2.png)

Ejemplo de salida antes de la configuración:
```
HTTP/1.1 200 OK
Date: Mon, 24 Feb 2025 11:01:49 GMT
Server: Apache/2.4.58 (Ubuntu)
Content-Type: text/html
```
Aquí, el encabezado `Server` indica la versión específica de Apache y el sistema operativo subyacente.

#### ✍️ Configurar Apache para ocultar la versión y la firma del servidor
Para evitar que esta información sea revelada, modifique el archivo de configuración principal de Apache en:
```bash
sudo nano /etc/apache2/apache2.conf
```
Añada o modifique las siguientes líneas:
```apache
# Eliminación de la información de las cabeceras
ServerTokens ProductOnly
ServerSignature Off
```
✅ Con `ServerTokens ProductOnly`, Apache solo revelará el producto (`Apache`), sin la versión ni el sistema operativo.
✅ Con `ServerSignature Off`, se elimina completamente la firma del servidor en las páginas de error y listados de directorios.

#### 🔄 Reiniciar Apache para aplicar los cambios
```bash
sudo systemctl restart apache2
```

#### 🔍 Verificar que los cambios han sido aplicados
Ejecute nuevamente:
```bash
curl --head localhost
```
Salida esperada después de la configuración:
```
HTTP/1.1 200 OK
Date: Mon, 24 Feb 2025 11:23:12 GMT
Server: Apache
Content-Type: text/html
```
✅ Ahora, el encabezado `Server` solo muestra `Apache`, sin información adicional.

---

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


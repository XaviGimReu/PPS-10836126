# 🛡️ Apache Hardening

## 📖 Introducción  

En este proyecto, exploramos diversas técnicas para **fortalecer la seguridad de Apache**, implementando configuraciones avanzadas y módulos de protección.

Entre las medidas de **hardening** aplicadas, incluimos:  

- ✅ **Deshabilitación de AutoIndex** para evitar la exposición de archivos y directorios.  
- ✅ **Configuración de cabeceras de seguridad** como **HSTS y CSP** para mitigar ataques XSS y de inyección.  
- ✅ **Integración de un Web Application Firewall (WAF)** mediante **ModSecurity** y las reglas OWASP CRS.  
- ✅ **Implementación del módulo `mod_evasive`** para mitigar ataques de denegación de servicio (DoS) y limitar accesos sospechosos.  
- ✅ **Restricción de accesos** y ajuste de permisos para mejorar la seguridad del servidor.  

Finalmente, por cada uno de los apartados que se vayan realizando **imagen Docker**, asegurando una implementación **segura, reproducible y fácilmente desplegable** en cualquier entorno.  

---

## 📦 Acceso a las imagenes en Docker Hub  

Para descargar y utilizar las imagenes con todas las configuraciones aplicadas, accede a:  

🔗 [**[Docker Hub - Apache Hardening](https://hub.docker.com/r/pps10836126/apache-hardening/tags)**]

---

## 📌 Prácticas Implementadas  

📂 **Apache Hardening:**  
- 🔹 **[Práctica 1: CSP](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_1)** – 🛠️ *Configuración inicial de seguridad en Apache y Configuración CSP.*  
- 🔹 **[Práctica 2: Web Application Firewall (WAF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_2)** – 🔒 *Configuración HTTPS segura con Let's Encrypt o certificados propios.*  
- 🔹 **[Práctica 3: OWASP](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_3)** – 🛡️ *Implementación de reglas OWASP para proteger aplicaciones web.*
- 🔹 **[Práctica 4: Evitar ataques DDoS](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_4)** – 🏆 *Mejores prácticas y auditoría de seguridad en Apache.*

📂 **Certificados:**  
- 🔹 **[Práctica 5: Certificado digital en Apache](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_5)** – 🔑 *Mejorando la seguridad con controles de acceso y permisos adecuados.*  

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


---

✍️ **Autor:** *Tu Nombre / Equipo*  
📅 **Última actualización:** *Febrero 2025*  

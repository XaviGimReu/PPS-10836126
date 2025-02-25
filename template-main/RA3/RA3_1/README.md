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
- 🔹 **[Práctica 1: CSP](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_1)** – 🛠️ *Configuración inicial de seguridad en Apache y Configuración de la política CSP.*  
- 🔹 **[Práctica 2: Web Application Firewall (WAF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_2)** – 🔒 *Configuración HTTPS segura con Let's Encrypt o certificados propios.*  
- 🔹 **[Práctica 3: OWASP](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_3)** – 🛡️ *Implementación de reglas OWASP para proteger aplicaciones web.*
- 🔹 **[Práctica 4: Evitar ataques DDoS](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_4)** – 🏆 *Mejores prácticas y auditoría de seguridad en Apache.*

📂 **Certificados:**  
- 🔹 **[Práctica 5: Certificado digital en Apache](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_5)** – 🔑 *Mejorando la seguridad con controles de acceso y permisos adecuados.*  

---

## 🔨 **Dockerfile**
Para automatizar la implementación de todas las configuraciones a implementar en un contenedor Docker, cree un archivo `Dockerfile` con el siguiente contenido:

```dockerfile
# Usar Ubuntu como base
FROM ubuntu:latest

# Actualizar paquetes e instalar Apache, OpenSSL y herramientas básicas
RUN apt update && apt install -y \
    apache2 apache2-utils openssl \
    nano iproute2 tree bash procps net-tools curl wget \
    && apt clean

# Coìar la configuración de Apache
COPY ./apache2.conf /etc/apache2/apache2.conf
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Crear directorio necesario para Apache
RUN mkdir -p /run/apache2

# Exponer los puertos HTTP y HTTPS
EXPOSE 80 443

# Mantener Apache en ejecución
CMD ["apachectl", "-D", "FOREGROUND"]
```
![DockerFile](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/Dockerfile.png)

## 🚀 **Docker**
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

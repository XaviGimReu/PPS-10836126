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
- 🔹 **[Práctica 1: CSP](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_1)** – 🛠️ *Configuración inicial de seguridad en Apache.*  
- 🔹 **[[Práctica 2: ](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_2)](#)** – 🔒 *Configuración HTTPS segura con Let's Encrypt o certificados propios.*  
- 🔹 **[Apache Hardening Best Practices](#)** – 🏆 *Mejores prácticas y auditoría de seguridad en Apache.*  

📂 **Certificados:**  
- 🔹 **[Configuración de ModSecurity (WAF)](#)** – 🛡️ *Implementación de reglas OWASP para proteger aplicaciones web.*  
- 🔹 **[Mitigación de ataques DoS con mod_evasive](#)** – 🚨 *Prevención de ataques de denegación de servicio (DoS).*  
- 🔹 **[Restricción de accesos y permisos](#)** – 🔑 *Mejorando la seguridad con controles de acceso y permisos adecuados.*  




---

✍️ **Autor:** *Tu Nombre / Equipo*  
📅 **Última actualización:** *Febrero 2025*  

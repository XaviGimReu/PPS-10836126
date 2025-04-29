# 🛡️ DOM Based Cross Site Scripting (XSS)

---

## 📖 Introducción

**DOM-Based XSS** es una variante de Cross Site Scripting en la que la inyección de código malicioso no pasa por el servidor, sino que se ejecuta directamente en el navegador del usuario mediante la manipulación del DOM (Document Object Model).

Esto ocurre cuando **datos no confiables son utilizados directamente en scripts del lado cliente**, sin una validación o sanitización adecuada.

En esta práctica trabajaremos con los tres niveles de seguridad en DVWA para entender cómo se produce esta vulnerabilidad y cómo puede ser explotada.

---

## 🔷 Nivel de Seguridad: Low

### 📌 Descripción

En este nivel, el valor del parámetro `default` de la URL es reflejado directamente en el HTML mediante JavaScript, sin ningún tipo de validación.


### 🛠️ Procedimiento

1. Accede al apartado **DOM Based XSS** y presiona el botón `Select`.

2. Observa que se utiliza el parámetro `default` en la URL:

```http
http://127.0.0.1/DVWA/vulnerabilities/xss_d/?default=English
```


📸 **Captura ejemplo del parámetro `default` en la URL:**


![menu](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/DOM_Based_Cross_Site_Scripting(XSS)%20-%20low_1.png)


3. Modifica el parámetro con el siguiente payload:

```html
<script>alert(document.cookie);</script>
```

📸 **Captura ejemplo del parámetro `default` en la URL:**


![DOM_XSS_low](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/DOM_Based_Cross_Site_Scripting(XSS)%20-%20low_2.png)

✅ El navegador ejecuta directamente el `alert()` mostrando la cookie.


## 📋 Resumen

- Se refleja directamente el valor del parámetro sin ningún tipo de filtrado o escape.

- La ejecución del script malicioso es inmediata.

- Esta es una de las formas más básicas de DOM XSS.


## 🛡️ Medidas de Mitigación

- Nunca insertar contenido controlado por el usuario directamente en el DOM sin validación.

- Utilizar funciones como `textContent` en lugar de `innerHTML`.

- Escapar caracteres especiales en cualquier entrada reflejada.

---

## 🔶 Nivel de Seguridad: Medium

### 📌 Descripción

En este nivel, el valor del parámetro está encerrado dentro de una etiqueta `<option>`, lo que impide el uso directo de etiquetas `<script>`. 

Sin embargo, **se puede romper la estructura HTML y utilizar una etiqueta alternativa como `<img>` con eventos JavaScript**.


### 🛠️ Procedimiento

1. Abre el apartado **DOM Based XSS**.

2. Introduce el siguiente payload:

```html
"></option></select><img src=x onerror="alert(document.cookie)">
```

📸 **Captura del ataque exitoso en nivel Medium:**


![DOM_XSS_med](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/DOM_Based_Cross_Site_Scripting(XSS)%20-%20med_1.png)

✅ Se rompe el contexto HTML y se ejecuta el `alert()` mediante un evento `onerror`.


## 📋 Resumen

- Aunque el contexto HTML intenta restringir el uso de scripts, no se filtran completamente.

- Es posible inyectar etiquetas HTML maliciosas mediante técnicas de escape.

- Aún hay una superficie de ataque relevante.


## 🛡️ Medidas de Mitigación

- No construir elementos HTML con datos de usuario directamente.

- Implementar listas blancas de valores permitidos.

- Aplicar codificación de salida y escape de atributos en todos los puntos de inserción


## 💠 Nivel de Seguridad: High

### 📌 Descripción

En este nivel, DVWA implementa una lista blanca de valores permitidos.

El parámetro `default` se filtra, pero **se puede inyectar código después del carácter `#`**, que es interpretado solo por el navegador y no enviado al servidor.


### 🛠️ Procedimiento

1. Modifica la URL e introduce el siguiente payload después del valor permitido:

```html
http://127.0.0.1/DVWA/vulnerabilities/xss_d/?default=English#<script>alert(document.cookie);</script>
```

📸 **Captura del ataque en nivel High:**


![DOM_XSS_high](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/DOM_Based_Cross_Site_Scripting(XSS)%20-%20high_1.png)

✅ El código inyectado se ejecuta desde el fragmento `#` de la URL, ya que sigue siendo interpretado por el DOM del navegador.


## 📋 Resumen

- La validación del parámetro `default` no bloquea el contenido después del `#`.

- Esta parte es interpretada por el navegador, lo que permite inyectar scripts.

- La protección es más robusta, pero aún existe un vector de ataque no controlado.


## 🛡️ Medidas de Mitigación

- Ignorar o sanitizar correctamente el contenido de la parte `#fragment` de la URL.

- Usar librerías como **DOMPurify** para limpiar cualquier entrada antes de manipular el DOM.

- Validar valores antes de que sean usados en cualquier asignación DOM directa.


---

## 📬 Referencias

**[Cross-Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Reflected Cross Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS)/Reflected%20Cross%20Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Stored Cross Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS)/Stored%20Cross%20Site%20Scripting%20(XSS))**

---

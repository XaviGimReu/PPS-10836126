# 🛡️ Reflected Cross Site Scripting (XSS)

---

## 📖 Introducción

**Reflected XSS** es una vulnerabilidad en la que los datos maliciosos enviados por el atacante a través de una URL o formulario son reflejados inmediatamente en la respuesta de la aplicación web sin ser almacenados.

Estos datos pueden contener scripts maliciosos que el navegador ejecutará, lo que puede llevar al robo de cookies, redirecciones o ejecución arbitraria de código.

En este apartado se analizarán los tres niveles de seguridad implementados por DVWA.

---

## 🔷 Nivel de Seguridad: Low

### 📌 Descripción

El valor introducido en el campo `What's your name?` se refleja directamente en el HTML sin ninguna validación ni codificación.


### 🛠️ Procedimiento

1. Accede al apartado **Reflected XSS** en DVWA.

2. Introduce el siguiente payload en el campo:

```html
<img src=x onerror="alert(document.cookie)">
```


📸 **Captura del ataque ejecutado correctamente en nivel Low:**


![Reflected_XSS_low](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Reflected_Cross_Site_Scripting(XSS)%20-%20low_1.png)

✅ El navegador interpreta el contenido malicioso e inmediatamente ejecuta `alert(document.cookie)`.


## 📋 Resumen

- El input se refleja directamente en la página sin ninguna validación.

- Es vulnerable a cualquier tipo de inyección de código JavaScript.

- Este nivel representa el caso más inseguro de Reflected XSS.


## 🛡️ Medidas de Mitigación

- Escapar adecuadamente los caracteres especiales en la salida (`<`, `>`, `"`, `'`, `&`).

- Utilizar frameworks que gestionen automáticamente la codificación de salida.

- No reflejar directamente ningún dato sin validarlo y sanearlo antes.

---

## 🔶 Nivel de Seguridad: Medium

### 📌 Descripción

Este nivel implementa filtrado básico, pero no lo suficientemente robusto. El mismo payload utilizado en el nivel Low todavía es funcional.


### 🛠️ Procedimiento

1. Repite el mismo procedimiento que en el nivel Low.

2. Introduce el payload:

```html
<img src=x onerror="alert(document.cookie)">
```

📸 **Captura del ataque en nivel Medium:**


![Reflected_XSS_med](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Reflected_Cross_Site_Scripting(XSS)%20-%20med_1.png)

✅ A pesar de estar en un nivel de seguridad superior, el payload aún es ejecutado.


## 📋 Resumen

- Existe un intento de protección, pero no se bloquean correctamente las etiquetas `<img>` ni los eventos como `onerror`.

- Las medidas implementadas no protegen contra los vectores más comunes.


## 🛡️ Medidas de Mitigación

- Implementar listas blancas de entrada válidas.

- Usar filtros más estrictos, especialmente en contextos HTML.

 -Reforzar la codificación de salida y revisar los puntos de inserción dinámicos.

---

## 💠 Nivel de Seguridad: High

### 📌 Descripción

En este nivel, DVWA intenta filtrar mejor los caracteres maliciosos y aplicar validaciones más sólidas. Sin embargo, el mismo payload sigue funcionando correctamente.


### 🛠️ Procedimiento

1. Introduce el mismo payload en el campo

```html
<img src=x onerror="alert(document.cookie)">
```

📸 **Captura del ataque en nivel High:**


![Reflected_XSS_high](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Reflected_Cross_Site_Scripting(XSS)%20-%20high_1.png)

✅ El código malicioso no es detectado ni filtrado, lo que permite explotar la vulnerabilidad incluso en el nivel High.


## 📋 Resumen

- A pesar de estar en el nivel más seguro, los controles son aún insuficientes.

- El uso de etiquetas HTML como `<img>` con atributos maliciosos sigue siendo efectivo.

- Se requieren mejoras considerables en la política de validación.


## 🛡️ Medidas de Mitigación

- Utilizar bibliotecas especializadas en sanitización como **DOMPurify**.

- Implementar políticas CSP (Content Security Policy) que bloqueen scripts externos.

- Validar la entrada tanto en el lado cliente como en el servidor.

---

## 📬 Referencias

**[Cross-Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[DOM Based Cross Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS)/DOM%20Based%20Cross%20Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Stored Cross Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS)/Stored%20Cross%20Site%20Scripting%20(XSS))**

---

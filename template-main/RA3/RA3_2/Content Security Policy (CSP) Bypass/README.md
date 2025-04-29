# 🛡️ Práctica: Content Security Policy (CSP) Bypass en DVWA

---

# 📖 Introducción

**Content Security Policy (CSP)** es una medida de seguridad implementada en aplicaciones web para evitar la ejecución de scripts maliciosos, como los ataques XSS.  
Mediante el uso de políticas declarativas, CSP define de qué fuentes externas se pueden cargar contenidos como scripts, estilos o imágenes.

Sin embargo, una mala configuración de CSP puede permitir que un atacante **evada estas restricciones** e inyecte código malicioso, comprometiendo así la seguridad de la aplicación.

Durante esta práctica se explora cómo vulnerar la política CSP en los niveles **Low** y **Medium** en DVWA.

---

# 🔷 Nivel de Seguridad: Low

## 📌 Descripción

En este nivel, la aplicación permite incluir scripts externos directamente desde dominios como **Pastebin** o **digi.ninja**, sin aplicar restricciones reales.

Esto permite al atacante cargar scripts maliciosos desde sitios externos, eludiendo por completo la protección que debería ofrecer CSP.

## 🛠️ Procedimiento

### 1. Cargar un script malicioso

Se introduce la siguiente URL externa que contiene un script JavaScript diseñado para robar cookies:

```text
https://digi.ninja/dvwa/cookie.js
```

📸 **Captura de ejecución del script desde URL externa:**


![CSP_Bypass_low](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Content_Security_Policy(CSP)_Bypass%20-%20low_1.png)

✅ Esto confirma que el navegador acepta y ejecuta scripts desde dominios externos sin restricción alguna, vulnerando el objetivo de CSP.


## 📋 Resumen

- No existe un `script-src` restrictivo en la política CSP.

- Se puede incluir y ejecutar cualquier script externo, incluso desde dominios controlados por un atacante.


## 🛡️ Medidas de Mitigación

- Definir correctamente `script-src` con fuentes confiables.

- Evitar el uso de `unsafe-inline` y `unsafe-eval`.

- Evitar permitir dominios genéricos como `*.com`.

---

# 🔶 Nivel de Seguridad: Medium

## 📌 Descripción

En este nivel, DVWA implementa un nonce para permitir solo scripts explícitamente autorizados.

Sin embargo, el valor del nonce es estático, lo cual permite al atacante reutilizarlo en su payload.


## 🛠️ Procedimiento

### 1. Inyectar código con el nonce estático

El nonce observado es:

```text
TmV2ZXIgZ29pbmcgdG8gZ2l2ZSB5b3UgdXA=
```

El siguiente payload aprovecha este valor para ejecutar código JavaScript inyectado:

```bash
<script nonce="TmV2ZXIgZ29pbmcgdG8gZ2l2ZSB5b3UgdXA=">alert(document.cookie)</script>
```

📸 **Captura de ejecución del script desde URL externa:**


![CSP_Bypass_med](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Content_Security_Policy(CSP)_Bypass%20-%20med_1.png)

✅ Esto demuestra que, al no ser dinámico, el nonce puede ser aprovechado por un atacante para evadir la política CSP.


## 📋 Resumen

- Aunque CSP usa nonce, su valor es **predecible** y **reutilizable**.

- El atacante puede incluir su propio script malicioso mientras use el mismo valor de nonce.


## 🛡️ Medidas de Mitigación (recomendadas adicionales)

- Generar nonces dinámicamente por cada solicitud.

- Nunca permitir fuentes externas no confiables en `script-src`.

- Utilizar mecanismos complementarios como Subresource Integrity (SRI).

---



---

## 📬 Referencias

**[Brute Force](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Brute%20Force)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Command Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Command%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross Site Request Forgery (CSRF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross%20Site%20Request%20Forgery%20(CSRF))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross-Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[SQL Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/SQL%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Weak Session IDs](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Weak%20Session%20IDs)**

---

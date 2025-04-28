# 🛡️ Práctica: Brute Force en DVWA

---

# 📖 Introducción

**Brute Force (Fuerza Bruta)** es una técnica de ataque que consiste en probar sistemáticamente múltiples combinaciones de nombres de usuario y contraseñas hasta encontrar las credenciales correctas. Es uno de los métodos más básicos pero efectivos para vulnerar sistemas con mecanismos de autenticación débiles o mal configurados.

Durante esta práctica se explorará cómo llevar a cabo un ataque de fuerza bruta utilizando la herramienta **Hydra** contra la sección de autenticación vulnerable de DVWA.

---

# 🔷 Nivel de Seguridad: Low

## 📌 Descripción

En el nivel **Low**, el formulario de autenticación no implementa ningún tipo de defensa contra ataques de fuerza bruta:

- No existe limitación de intentos.
  
- No se utilizan mecanismos como CAPTCHAs o bloqueos de cuenta.
  
- La respuesta del servidor diferencia entre credenciales correctas e incorrectas.

Esto facilita enormemente la ejecución de ataques automatizados.


## 🛠️ Procedimiento

### 1. Configuración del ataque

Utilizamos **Hydra** para realizar el ataque de fuerza bruta.  
Se configura el ataque de la siguiente manera:

```bash
hydra -l admin -P /usr/share/wordlists/rockyou.txt 127.0.0.1 http-get-form "/DVWA/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:Username and/or password incorrect." -m "Cookie: security=low; PHPSESSID=XXXXXXXXXXXX"
```

Donde:

- `-l admin`: login objetivo (admin).

- `-P /usr/share/wordlists/rockyou.txt`: diccionario de contraseñas.

- `http-get-form`: tipo de petición.

- `PHPSESSID`: ID de sesión activa en DVWA.
  

📸 **Captura de ejecución del ataque con Hydra:**


![hydra](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Brute_Force%20-%20low_1.png)

✅ Esto demuestra que se pueden encontrar múltiples contraseñas válidas sin ninguna restricción, validando que el sistema es vulnerable a fuerza bruta.


## 📋 Resumen

- La ausencia de limitaciones de intentos permite un ataque exitoso de fuerza bruta.

- Hydra encuentra varias combinaciones válidas de contraseñas en poco tiempo.

- El sistema responde de forma diferenciada a credenciales correctas e incorrectas, facilitando la automatización.

## 🛡️ Medidas de Mitigación

- Implementar bloqueo de cuenta tras varios intentos fallidos consecutivos.

- Utilizar CAPTCHAs para dificultar ataques automatizados.

- Homogeneizar las respuestas del servidor (misma respuesta para éxito o fallo).

- Emplear mecanismos de protección de acceso como autenticación multifactor (MFA).

---

# 🔶 Nivel de Seguridad: Medium

## 📌 Descripción

En el nivel **Medium**, DVWA introduce algunas medidas básicas de protección contra ataques de fuerza bruta:

- Incremento del tiempo de respuesta del servidor tras intentos fallidos.
- Posibles cambios en la estructura del formulario para dificultar la automatización.

Estas medidas tienen como objetivo aumentar el tiempo requerido para completar un ataque de fuerza bruta, haciéndolo inviable en la práctica.


## 🛠️ Procedimiento

### 1. Configuración del ataque

Se intentó realizar un ataque de fuerza bruta utilizando **Hydra** con los mismos parámetros utilizados en el nivel **Low**.


### 2. Resultado de la ejecución

Durante la ejecución del ataque, se observó que:

- El tiempo estimado para completar el ataque era superior a **52 horas**.
- El servidor ralentiza deliberadamente las respuestas después de múltiples intentos fallidos.
  
Debido al tiempo excesivo requerido, se decidió **no completar el ataque** para no comprometer los recursos del entorno de prácticas.

---

## 📋 Resumen

- La ralentización progresiva de las respuestas del servidor impide la ejecución práctica del ataque de fuerza bruta.

- El entorno Medium de DVWA demuestra ser efectivo en la mitigación de ataques automatizados simples.

---

## 🛡️ Medidas de Mitigación (recomendadas adicionales)

- Implementar bloqueos de IP tras varios intentos fallidos.
  
- Utilizar autenticación multifactor (MFA).
  
- Limitar las tasas de intentos por cuenta o IP (Rate Limiting).

---



---

## 📬 Referencias
**[Command Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Command%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Content Secutiry Policy (CSP) Bypass](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Content%20Security%20Policy%20(CSP)%20Bypass)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross Site Request Forgery (CSRF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross%20Site%20Request%20Forgery%20(CSRF))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross-Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[SQL Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/SQL%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Weak Session IDs](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Weak%20Session%20IDs)**

---

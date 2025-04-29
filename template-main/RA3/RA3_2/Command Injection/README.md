# 🛡️ Práctica: Command Injection en DVWA

---

# 📖 Introducción

**Command Injection (Inyección de Comandos)** es una vulnerabilidad que ocurre cuando una aplicación permite la ejecución de comandos del sistema operativo con entrada controlada por el usuario. Un atacante puede aprovechar esta vulnerabilidad para ejecutar comandos arbitrarios en el servidor, comprometiendo gravemente la seguridad del sistema.

Durante esta práctica se explorará la explotación de esta vulnerabilidad en los niveles de seguridad **Low**, **Medium** y **High** en DVWA.

---

# 🔷/🔶/💠 Nivel de Seguridad: Low, Medium y High

## 📌 Descripción

En el nivel **Low**, DVWA no realiza ningún tipo de filtrado o validación sobre la entrada del usuario, permitiendo ejecutar comandos directamente en el sistema operativo.

---

## 🛠️ Procedimiento

### 1. Ejecución de un comando legítimo

Inicialmente, se introduce una dirección IP o el nombre `localhost` para realizar un **ping** normal.

📸 **Captura de la ejecución del ping legítimo:**

![ping](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Command_Injection%20-%20low%26mid%26high_1.png)

✅ Esto confirma que la aplicación ejecuta el comando `ping` en el sistema operativo con la entrada proporcionada por el usuario.

---

### 2. Explotación de la vulnerabilidad

Se introduce una carga maliciosa para ejecutar un comando arbitrario:

```bash
|ls
```

Esto permite listar el contenido del directorio del servidor.

📸 **Captura de la ejecución del comando (`ls`):**

![ejecucion_ls](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_2/assets/Command_Injection%20-%20low%26mid%26high_2.png)

✅ Esto confirma que la aplicación es vulnerable a inyección de comandos, permitiendo ejecutar instrucciones arbitrarias en el sistema operativo.


## 📋 Resumen

- La ausencia de validación permite la ejecución de comandos arbitrarios desde la entrada del usuario.

- Se compromete la integridad del servidor ejecutando comandos como `ls`, `whoami`, `cat`, etc.


## 🛡️ Medidas de Mitigación

- Validar y sanitizar adecuadamente toda la entrada del usuario.

- Utilizar funciones seguras para ejecutar comandos (`escapeshellarg`, `escapeshellcmd`).

- Evitar el uso directo de entradas de usuario en funciones que ejecutan comandos del sistema operativo.

---

## 📬 Referencias
**[Brute Force](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Brute%20Force)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Content Secutiry Policy (CSP) Bypass](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Content%20Security%20Policy%20(CSP)%20Bypass)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross Site Request Forgery (CSRF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross%20Site%20Request%20Forgery%20(CSRF))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Cross-Site Scripting (XSS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Cross-Site%20Scripting%20(XSS))**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[SQL Injection](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/SQL%20Injection)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Weak Session IDs](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_2/Weak%20Session%20IDs)**

---

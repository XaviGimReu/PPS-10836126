# 🔒 Práctica 1: CSP

## 📌 Introducción a CSP
La **Política de Seguridad de Contenidos (CSP)** es una capa de seguridad adicional que ayuda a prevenir ataques como **Cross-Site Scripting (XSS)** y otros ataques de inyección de código malicioso. CSP restringe las fuentes desde donde se pueden cargar ciertos tipos de contenido en un sitio web, mejorando así la seguridad del servidor y del usuario final.

Al implementar CSP en un servidor Apache, se puede reducir el riesgo de ejecución de scripts maliciosos, asegurando que solo se carguen recursos confiables. A continuación, se detallan las configuraciones necesarias para aplicar esta política junto con otras medidas de seguridad.

---

## 🏗️ **Configuración de Apache**
En este apartado se realizarán una serie de configuraciones previas en el servicio Apache para posiblitar la posterior implementación de CSP.

### 🔹 Deshabilitar el módulo `autoindex`
Este módulo permite la generación automática de listados de directorios en caso de que no exista un archivo `index.html` o `index.php`. Para desactivarlo, ejecute:
```bash
a2dismod autoindex
```
![autoindex](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/3.%20deshabilitar_autoindex.png)

✅ Esto previene la exposición accidental de archivos y directorios sensibles.

### 🔹 Ocultar la información del servidor en las cabeceras HTTP
Por defecto, Apache muestra información sobre su versión y sistema operativo en las respuestas HTTP. Esta información puede ser utilizada por atacantes para identificar vulnerabilidades específicas.

#### 🔍 Verificar la información expuesta
Para comprobar qué información está siendo expuesta por Apache, ejecute:
```bash
curl --head localhost
```

Ejemplo de salida antes de la configuración:
```
HTTP/1.1 200 OK
Date: Mon, 24 Feb 2025 11:01:49 GMT
Server: Apache/2.4.58 (Ubuntu)
Content-Type: text/html
```
![curl](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/4.%20ejecuci%C3%B3n_cabecera.png)

Aquí, el encabezado `Server` indica la versión específica de Apache y el sistema operativo subyacente.

#### ✍️ Configurar Apache para ocultar la versión y la firma del servidor
Para evitar que esta información sea revelada, modifique el archivo de configuración principal de Apache en:
```bash
nano /etc/apache2/apache2.conf
```
Añada o modifique las siguientes líneas:
```apache
# Eliminación de la información de las cabeceras
ServerTokens ProductOnly
ServerSignature Off
```
![apache2.conf](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/5.%20eliminaci%C3%B3n_cabeceras.png)

✅ Con `ServerTokens ProductOnly`, Apache solo revelará el producto (`Apache`), sin la versión ni el sistema operativo.
✅ Con `ServerSignature Off`, se elimina completamente la firma del servidor en las páginas de error y listados de directorios.

#### 🔄 Reiniciar Apache para aplicar los cambios
```bash
service apache2 reload
```

#### 🔍 Verificar que los cambios han sido aplicados
Ejecute nuevamente:
```bash
curl --head localhost
```
Salida esperada después de la configuración:
```
HTTP/1.1 200 OK
Date: Mon, 24 Feb 2025 11:23:12 GMT
Server: Apache
Content-Type: text/html
```
![header](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/6.%20eliminaci%C3%B3n_cabeceras-2.png)

✅ Ahora, el encabezado `Server` solo muestra `Apache`, sin información adicional.

---

## 📂 Configurar la cabecera **HSTS**
HSTS **(HTTP Strict Transport Security)** es una política de seguridad que obliga a los navegadores a usar HTTPS para comunicarse con el servidor.

Para habilitarlo en Apache, primero active el módulo `headers`:
```bash
a2enmod headers
service reload apache2
```
Luego, agregue la siguiente línea en el archivo de configuración del host virtual:
```apache
<VirtualHost *:443>
    ...
    Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains"
    ...
</VirtualHost>
```
![HSTS](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/7.%20HSTS.png)

✅ Esto obliga a los navegadores a usar conexiones seguras durante **2 años**.

---

## 🛡️  Configurar la cabecera **CSP**
Para mejorar la seguridad contra ataques XSS y evitar la ejecución de scripts no confiables, agregue la siguiente directiva en la configuración de Apache:
```apache
Header set Content-Security-Policy "default-src 'self'; script-src 'self'"
```
![CSP](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/CSP/9.%20Certificado-2.png)

✅ Este ejemplo establece que:
- Todo el contenido debe provenir del mismo origen (`'self'`), lo que significa que solo los recursos alojados en el mismo dominio serán permitidos.
- Los scripts (`script-src`) solo pueden ejecutarse desde el mismo origen (`'self'`), evitando la ejecución de scripts inyectados desde fuentes externas

📌 Nota: Esta configuración de CSP ayuda a mitigar ataques de XSS restringiendo la carga de contenido a solo fuentes de confianza. Se recomienda probar exhaustivamente la política en un entorno de desarrollo antes de implementarla en producción para evitar bloquear contenido legítimo.

---


## 📬 Referencias
**[RA3_1_2(WAF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_2)**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
**[RA3_1_3(OWASP)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_3)**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
**[RA3_1_4(Ataques DDoS)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_4)**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
**[RA3_1_5(Certificado digital)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_5)**

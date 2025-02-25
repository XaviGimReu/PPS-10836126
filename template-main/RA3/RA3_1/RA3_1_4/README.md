# ⚔️🚫 Práctica 4: Protección contra ataques DoS en Apache

## 📌 Introducción a mod_evasive

**mod_evasive** es un módulo para Apache que detecta y mitiga ataques de **Denegación de Servicio (DoS)** y **fuerza bruta**. Este módulo monitoriza las solicitudes entrantes y bloquea aquellas que superen ciertos umbrales configurados.

### 🔍 Características principales:
- 🚫 **Protección contra múltiples solicitudes en un corto periodo de tiempo**
- 🚫 **Bloqueo de IPs maliciosas de manera automática**
- 🚫 **Registro de eventos y posibilidad de integración con firewalls externos**

---

## ⚙️ Instalación y configuración de mod_evasive en Apache

### 🔹 Instalación del módulo mod_evasive

1️⃣ Instalar el módulo mod_evasive en Apache:
```bash
apt update && apt install -y libapache2-mod-evasive
```

2️⃣ Verificar que el módulo ha sido instalado correctamente:
```bash
apachectl -M | grep evasive
```
✅ Si el módulo está habilitado, verá una línea similar a:
```bash
evasive20_module (shared)
```

---

### 🔹 Configuración de mod_evasive

1️⃣ Editar la configuración del módulo:
```bash
sudo nano /etc/apache2/mods-available/evasive.conf
```

2️⃣ Configurar los parámetros básicos:
```apache
<IfModule mod_evasive20.c>
    DOSHashTableSize    3097
    DOSPageCount        2      # Número máximo de solicitudes por segundo antes del bloqueo
    DOSSiteCount        50     # Número máximo de solicitudes totales al servidor
    DOSPageInterval     1      # Intervalo de tiempo en segundos para contar las solicitudes
    DOSSiteInterval     1
    DOSBlockingPeriod   10     # Tiempo en segundos que una IP permanecerá bloqueada
    DOSLogDir           "/var/log/mod_evasive"
</IfModule>
```

✅ **Explicación de la configuración:**
- **DOSPageCount:** Número de peticiones por segundo permitidas antes del bloqueo.
- **DOSBlockingPeriod:** Tiempo en que la IP permanecerá bloqueada.
- **DOSLogDir:** Carpeta donde se registrarán los eventos de denegación.

3️⃣ Crear el directorio de logs y establecer permisos:
```bash
mkdir /var/log/mod_evasive
chmod 777 /var/log/mod_evasive
```

4️⃣ Habilitar el módulo y reiniciar Apache:
```bash
a2enmod evasive
systemctl restart apache2
```

✅ Ahora el módulo **mod_evasive** está activo y protegiendo Apache contra ataques DoS.

---

## 🔍 **Prueba de mod_evasive con Apache Bench**

Para comprobar que **mod_evasive** está funcionando correctamente, utilizaremos la herramienta `ab` (Apache Bench) para enviar múltiples solicitudes en un corto periodo de tiempo.

### 🔹 Simulación de ataque con Apache Bench

1️⃣ Instalar Apache Bench si no está disponible:
```bash
apt install -y apache2-utils
```

2️⃣ Ejecutar la prueba de estrés con `ab`:
```bash
ab -n 1000 -c 50 http://localhost/
```
📌 **Explicación de los parámetros:**
- `-n 1000` → Número total de solicitudes a enviar.
- `-c 50` → Número de solicitudes concurrentes.

3️⃣ Verificar si la IP ha sido bloqueada revisando los logs:
```bash
tail -f /var/log/apache2/error.log
```
📸 **Captura de logs de bloqueo:**
![mod_evasive log](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/DOS/1.png)

✅ Si la prueba ha sido exitosa, algunas solicitudes deberían ser **rechazadas con un código 403 Forbidden**.

📸 **Captura de Apache Bench mostrando bloqueos:**
![Apache Bench](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA3/RA3_1/assets/DOS/2.png)

---

## 🐳 **Crear una imagen Docker con mod_evasive preconfigurado**

Para facilitar la implementación en otros entornos, podemos crear un contenedor Docker con **Apache y mod_evasive** ya configurados.

### 📌 **Dockerfile**
```dockerfile
FROM httpd:2.4

# Instalar mod_evasive
RUN apt update && apt install -y libapache2-mod-evasive && \
    mkdir /var/log/mod_evasive && chmod 777 /var/log/mod_evasive && \
    echo '<IfModule mod_evasive20.c>\nDOSHashTableSize 3097\nDOSPageCount 2\nDOSSiteCount 50\nDOSPageInterval 1\nDOSSiteInterval 1\nDOSBlockingPeriod 10\nDOSLogDir "/var/log/mod_evasive"\n</IfModule>' \
    > /etc/apache2/mods-available/evasive.conf && \
    a2enmod evasive

# Exponer el puerto 80
EXPOSE 80
CMD ["httpd-foreground"]
```

### 🚀 **Construcción y ejecución del contenedor**

1️⃣ **Construir la imagen Docker:**
```bash
docker build -t apache-mod_evasive .
```

2️⃣ **Ejecutar el contenedor:**
```bash
docker run --detach --rm -p 8080:80 --name="secure-apache" apache-mod_evasive
```

✅ Ahora Apache ejecuta mod_evasive en un entorno **contenedorizado**, protegiendo contra ataques DoS.

---

## 📬 Referencias
**[RA3_1_1 (CSP)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_1)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_2 (WAF)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_2)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_3 (OWASP)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_3)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[RA3_1_5 (Certificado digital)](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA3/RA3_1/RA3_1_5)**

---


# Práctica 1: CSP

Introduction [INTRO](URL_TASKS) :

# Tasks

* [TASK_1](#URL_TASK_1): XXX
* [TASK_2](#URL_TASK_2): XXX

# Task_1

Intro...

![IMG](URL_IMG)

Example code:

```
$ git clone https://github.com/openssh/openssh-portable
$ patch -p1 < ~/path/to/openssh.patch
$ autoreconf
$ ./configure
$ make
```

# Task_2
# 🛡️ Apache Hardening con Docker

## 📖 Introducción

Este proyecto demuestra cómo implementar **Apache Hardening** dentro de un contenedor Docker.  
Se incluyen medidas de seguridad avanzadas y optimización del servidor web para fortalecer su seguridad.

Las principales configuraciones incluyen:
- ✅ Instalación de **Apache** con módulos esenciales.
- ✅ Implementación de **configuración segura** y archivos personalizados.
- ✅ **Creación y ejecución de un contenedor Docker** con Apache.
- ✅ **Acceso al contenedor** para administración y pruebas.

---

## 🚀 Pasos para la Instalación y Ejecución

### **1️⃣ Construcción de la Imagen Docker**
Para crear la imagen de Apache con las configuraciones aplicadas, ejecuta el siguiente comando:

docker build -t apache-hardening -f apache-hardening .

📌 Explicación:

    -t apache-hardening → Asigna el nombre apache-hardening a la imagen.
    -f apache-hardening → Especifica el archivo Dockerfile a utilizar.

✅ Resultado esperado:
La imagen apache-hardening se crea correctamente, como se muestra en la siguiente imagen:

2️⃣ Verificar la Imagen Creada

Una vez creada la imagen, verifica que está disponible en Docker ejecutando:

docker images

✅ Resultado esperado:
Debe aparecer apache-hardening en la lista de imágenes disponibles.
3️⃣ Ejecutar el Contenedor con Apache

Para iniciar un contenedor basado en la imagen recién creada, usa el siguiente comando:

docker run -d -p 8080:80 -p 8443:443 --name apache-server apache-hardening

📌 Explicación de los parámetros:

    -d → Ejecuta el contenedor en modo detached (en segundo plano).
    -p 8080:80 → Expone el puerto 80 del contenedor en el 8080 del host.
    -p 8443:443 → Expone el puerto 443 del contenedor en el 8443 del host.
    --name apache-server → Asigna el nombre apache-server al contenedor.

✅ Resultado esperado:
Apache estará corriendo dentro del contenedor y accesible a través de los puertos expuestos.
4️⃣ Verificar Contenedores Activos

Para comprobar que el contenedor está en ejecución, usa:

docker ps -a

✅ Resultado esperado:
Debe aparecer apache-server en estado "Up", lo que indica que el servidor Apache está activo.
5️⃣ Acceder al Contenedor

Para abrir una terminal dentro del contenedor en ejecución, ejecuta:

docker exec -it apache-server bash

📌 Explicación:

    docker exec → Ejecuta un comando dentro del contenedor.
    -it → Inicia una sesión interactiva.
    apache-server → Nombre del contenedor.
    bash → Abre una terminal dentro del contenedor.

✅ Resultado esperado:
Se obtiene acceso a la terminal del contenedor, como se muestra en la siguiente imagen:

🎯 Conclusión

Con estos pasos, hemos desplegado Apache en un contenedor Docker con configuraciones de seguridad aplicadas.
Esta configuración permite pruebas seguras y gestión eficiente de servidores web en contenedores.

🚀 ¡Este repositorio está en constante actualización!
🔧 Sugerencias y mejoras son bienvenidas.

✍️ Autor: Tu Nombre / Equipo
📅 Última actualización: Febrero 2025


---

🔹 **Ahora solo tienes que copiar y pegar este contenido en tu `README.md` en GitHub!** 🚀🔥


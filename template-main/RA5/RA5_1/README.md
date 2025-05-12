# 🛠️ Jenkins + Python + Docker: CI/CD Automatizado

## 📖 Introducción

En esta práctica se ha desarrollado un sistema de **Integración Continua (CI)** y **Entrega Continua (CD)** utilizando **Jenkins**, aplicado a un proyecto en Python.  

A través de esta implementación se han automatizado tareas de compilación, testeo y despliegue dentro de contenedores Docker.

Entre las acciones realizadas, se incluye:

- ✅ Configuración de un **proyecto Python** con pruebas unitarias (`unittest`)

- ✅ Implementación de una **pipeline tradicional** en Jenkins (con `Jenkinsfile`)

- ✅ Automatización con **Docker**: construcción, ejecución y testing en contenedores

- ✅ Uso de **webhooks y ngrok** para ejecución automática desde GitHub

- ✅ Configuración de un entorno reproducible mediante **`docker-compose`**

Finalmente, se consolidó el proceso en un fichero `Jenkinsfile.docker` permitiendo replicar la integración de forma segura y automatizada.

---


## 📌 Prácticas Implementadas

📂 **Integración Continua con Jenkins:**
- 🔹 **Pipeline Tradicional** – 📦 *Ejecución de tests tras commit automático desde GitHub*
- 🔹 **Webhook GitHub + Ngrok** – 🔁 *Desencadenar pipeline al hacer push*
- 🔹 **Pipeline Dockerizada** – 🐳 *Tests ejecutados completamente dentro de contenedores Docker*

---

## 🔨 Dockerfile

```dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir pytest
CMD ["pytest", "test_calculadora.py"]
```

🧬 Enlace al **![Dockerfile](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_1/Dockerfile)**

---

## 🧪 Jenkinsfile.docker

```groovy
pipeline {
    agent any

    stages {
        stage('Construir imagen Docker') {
            steps {
                dir('template-main/RA5/RA5_1') {
                    sh 'docker build -t calculadora-ci .'
                }
            }
        }

        stage('Ejecutar contenedor') {
            steps {
                dir('template-main/RA5/RA5_1') {
                    sh 'docker run --name contenedor-calculadora -d calculadora-ci tail -f /dev/null'
                }
            }
        }

        stage('Ejecutar tests en el contenedor') {
            steps {
                dir('template-main/RA5/RA5_1') {
                    sh 'docker exec contenedor-calculadora pytest test_calculadora.py'
                }
            }
        }

        stage('Detener y eliminar contenedor') {
            steps {
                dir('template-main/RA5/RA5_1') {
                    sh '''
                        docker stop contenedor-calculadora
                        docker rm contenedor-calculadora
                    '''
                }
            }
        }

        stage('Ejecutar docker-compose') {
            steps {
                dir('template-main/RA5/RA5_1') {
                    sh 'docker-compose up --build -d'
                }
            }
        }
    }

    post {
        always {
            echo '🧹 Limpieza completada'
        }
        success {
            echo '✅ Pipeline completada exitosamente'
        }
        failure {
            echo '❌ Fallo en alguna etapa'
        }
    }
}
```

🧬 Enlace al **![Jenkinsfile.docker](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_1/Jenkinsfile.docker)**

---

## 📂 Archivos del proyecto

- `calculadora.py`: función principal

- `test_calculadora.py`: pruebas `unittest`

- `Dockerfile`: configuración del entorno Python

- `docker-compose.yml`: despliegue de servicio

- `Jenkinsfile.docker`: CI/CD completo con Docker

---

# 🧪 Ejecución y pruebas

En esta sección se documenta el proceso de ejecución de la pipeline tradicional y dockerizada, así como los resultados obtenidos durante las pruebas.


### 🔹 1. Ejecución local del programa y test en terminal

Se ejecuta la calculadora desde terminal con Python 3 y luego se corren las pruebas unitarias con `unittest`.

```bash
python3 calculadora.py 7 5
python3 -m unittest test_calculadora.py
```

📸 **Captura de:**  

![ejecucion_pruebas](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_1/assets/pruebas_ejecucion.png)



---

### 🔹 2. Ejecución de pipeline tradicional en Jenkins

Una vez configurado Jenkins y vinculado al repositorio, se realiza un `push` al repositorio y Jenkins detecta el cambio ejecutando la pipeline definida en `Jenkinsfile`.

📸 **Captura:**

![ejecucion_pipeline](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_1/assets/ejecucion_pipeline.png)


---

### 🔹 3. Error intencionado detectado en Jenkins

Para comprobar el control de errores, se modifica la función `multiplicar` para forzar una división entre cero:

```python
return a / 0
```

📸 **Captura:**  
![error_intencionado](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_1/assets/error_intencionado.png)


El sistema detecta el fallo y marca la ejecución como fallida.

📸 **Captura:**  
![prueba_error](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_1/assets/prueba_error.png)

---

### 🔹 4. Configuración de webhook con ngrok

Se utiliza ngrok para exponer Jenkins y permitir que GitHub envíe notificaciones cuando se hace un commit.

```bash
ngrok http 49001
```

📸 **Captura:**  
![exposicion_ngrok](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_1/assets/exposicion_ngrok.png)

---

### 🔹 5. Verificación de ejecución automática

Una vez configurado el webhook, cada `git push` genera automáticamente un nuevo build en Jenkins.

📸 **Captura:**  
![build_automatico](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_1/assets/build_automatico.png)


También veremos que en la terminal donde lanzamos **Ngrok** aparece una conexión `200 OK`.

📸 **Captura:**  
![build_automatico_ngrok](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_1/assets/build_automatico_ngrok.png)


---

### 🔹 6. Pipeline Docker ejecutando todos los stages

Se lanza un nuevo job en Jenkins utilizando `Jenkinsfile.docker`. Jenkins realiza las siguientes etapas:

1. Construcción de la imagen

2. Ejecución del contenedor

3. Ejecución de los tests dentro del contenedor

4. Eliminación del contenedor

5. Ejecución de docker-compose


📸 **Captura:**  
![Docker Pipeline](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_1/assets/pipeline_jenkinsfile_docker.png)


---

## ✅ Conclusión

Se logró implementar con éxito un entorno completo de integración y entrega continua sobre Jenkins, utilizando contenedores Docker y prácticas reales de automatización.  
El proyecto permite validar código Python, ejecutar tests automáticamente y construir imágenes reproducibles listas para producción.

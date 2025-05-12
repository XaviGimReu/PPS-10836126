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

📸 Ejemplo del **Dockerfile**:  
![Dockerfile](assets/Dockerfile.png)

---

## 🧪 Jenkinsfile.docker

```groovy
pipeline {
    agent any

    stages {
        stage('Construir imagen Docker') {
            steps {
                sh 'docker build -t calculadora-ci .'
            }
        }
        stage('Ejecutar contenedor') {
            steps {
                sh 'docker run --name contenedor-calculadora -d calculadora-ci tail -f /dev/null'
            }
        }
        stage('Ejecutar tests en el contenedor') {
            steps {
                sh 'docker exec contenedor-calculadora pytest test_calculadora.py'
            }
        }
        stage('Detener y eliminar contenedor') {
            steps {
                sh '''
                    docker stop contenedor-calculadora
                    docker rm contenedor-calculadora
                '''
            }
        }
        stage('Ejecutar docker-compose') {
            steps {
                sh 'docker-compose up --build -d'
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

---

## 📂 Archivos del proyecto

- `calculadora.py`: función principal
- `test_calculadora.py`: pruebas `unittest`
- `Dockerfile`: configuración del entorno Python
- `docker-compose.yml`: despliegue de servicio
- `Jenkinsfile.docker`: CI/CD completo con Docker

---

## 🧪 Ejecución y pruebas

📸 Ejemplo de ejecución local de pruebas:
![Pruebas OK](assets/unittest_ok.png)

📸 Jenkins ejecutando build exitoso:
![Build OK](assets/build_ok.png)

📸 Error intencional detectado por Jenkins:
![Error detectado](assets/build_fail_div0.png)

📸 Ngrok recibiendo webhook:
![Webhook OK](assets/ngrok_webhook.png)

📸 Histórico de builds automatizados:
![AutoBuild](assets/build_auto_trigger.png)

📸 Pipeline Docker ejecutando stages:
![Docker Pipeline](assets/docker_pipeline.png)

---

## ✅ Conclusión

Se logró implementar con éxito un entorno completo de integración y entrega continua sobre Jenkins, utilizando contenedores Docker y prácticas reales de automatización.  
El proyecto permite validar código Python, ejecutar tests automáticamente y construir imágenes reproducibles listas para producción.

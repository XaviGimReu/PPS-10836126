# 📊 K3s + K9s: Despliegue y Validación en Entorno Kubernetes (RA5.4)

## 📖 Introducción

En esta práctica se ha desarrollado una arquitectura de despliegue y administración de contenedores utilizando **K3s**, una distribución ligera de Kubernetes, y **K9s**, una herramienta de terminal para gestionar clústeres Kubernetes.

La actividad está enfocada en la validación del entorno Kubernetes mediante tres enfoques clave:

* 🟢 Despliegue inicial en **modo single-node** con un servicio de nginx replicado.
* 🔄 Escalado del entorno a un clúster **HA (High Availability)**.
* 🧱 Despliegue a partir de un archivo `docker-compose` convertido a recursos Kubernetes mediante `Kompose`.

---

## 📌 Prácticas Implementadas

📂 **Despliegue y Gestión Kubernetes con K3s + K9s:**

* 🔹 **Single-node Deployment** – ⚙️ Instalación de K3s en modo local, despliegue de nginx y validación con K9s.
* 🔹 **Clúster HA** – 🧩 Instalación de K3s con `--cluster-init` y configuración para admitir múltiples nodos.
* 🔹 **Kompose + Docker Compose** – 🐳 Conversión de `docker-compose.yml` a manifiestos Kubernetes y despliegue en K3s.

---

# 🧩 5. Actividades

## 🔹 5.1 Instalación y validación de K3s en modo single-node

Este apartado tiene como objetivo crear un clúster local de Kubernetes con **K3s** sobre un solo nodo y desplegar un servicio web `nginx` replicado.

### 🛠 Instalación de K3s

La instalación se realiza mediante un script oficial:

```bash
curl -sfL https://get.k3s.io | sh -
```

Este comando descarga e instala `k3s`, junto con `kubectl`, el cliente de línea de comandos para Kubernetes.

📸 **Evidencia:**
![instalacion\_k3s](assets/1.%20Instalación%20k3s.png)

---

### 📦 Despliegue de nginx con 2 réplicas

Se define un `Deployment` para lanzar dos réplicas de nginx. Esto permite validar la capacidad de Kubernetes de manejar cargas replicadas.

📄 **Archivo `nginx_deployment.yml`:**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
```

📸 **Evidencia:**
![deploy\_nginx](assets/2.%20Configuración%20y%20lanzamient%20de%20nginx.png)

---

### 🔍 Verificación de los pods

Se comprueba que las dos réplicas de nginx estén en estado `Running`:

```bash
kubectl get pods
```

📸 **Evidencia:**
![verificacion\_nginx](assets/3.%20Verificación%20de%20lanzamiento.png)

---

### 📥 Instalación y ejecución de K9s

Se utiliza K9s para una visualización en tiempo real del estado del clúster y sus recursos.

```bash
curl -sS https://webinstall.dev/k9s | bash
k9s
```

📸 **Evidencias:**

* ![instalacion\_k9s](assets/4.%20Instalación%20k9s.png)
* ![lanzamiento\_k9s](assets/5.%20Lanzamiento%20k9s.png)

---

## 🔹 5.2 Instalación y validación de K3s en modo HA

Este apartado busca convertir el clúster en un entorno **altamente disponible**, habilitando la opción `--cluster-init` para permitir la incorporación de nodos adicionales.

### 🛠 Instalación inicial en modo HA

```bash
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init" sh -
```

📸 **Evidencia:**
![instalacion\_ha](assets/6.%20Instalación%20k3s%20\(HA\).png)

---

### 🔑 Obtención del token del nodo líder

Este token es necesario para que los nuevos nodos se unan al clúster:

```bash
sudo cat /var/lib/rancher/k3s/server/node-token
```

📸 **Evidencia:**
![token\_ha](assets/7.%20Token%20del%20nodo1.png)

---

### 🌐 Simulación de unión de un nuevo nodo

Se documenta el comando de unión:

```bash
curl -sfL https://get.k3s.io | \
K3S_URL=https://192.168.1.49:6443 \
K3S_TOKEN=<TOKEN> sh -
```

📸 **Evidencia:**
![union\_nodo](assets/8\(0\).%20Union%20otro%20nodo.png)

---

### 📦 Despliegue del servicio nginx (modo HA)

El mismo manifiesto de despliegue se aplica en el clúster HA:

```bash
kubectl apply -f ha_nginx_deployment.yml
```

📸 **Evidencia:**
![deploy\_ha](assets/8.%20Despliegue%20ha_nginx_deployment.yml.png)

---

## 🔹 5.3 Despliegue con docker-compose y validación en K3s

Este apartado valida la integración entre aplicaciones existentes en `docker-compose` y su conversión a Kubernetes mediante `Kompose`.

### 📝 Archivo docker-compose

```yaml
version: "3"
services:
  web1:
    image: nginx
  web2:
    image: nginx
  balanceador:
    image: nginx
    ports:
      - "8080:80"
```

📸 **Evidencia:**
![compose\_file](assets/9.%20docker-compose.yml.png)

---

### 🔁 Conversión a manifiestos Kubernetes con Kompose

```bash
kompose convert
```

Esto genera los archivos YAML necesarios para cada servicio y su deployment correspondiente.

📸 **Evidencia:**
![kompose\_convert](assets/10.%20Despliegue%20de%20docker-compose.png)

---

### 🌍 Exposición del balanceador nginx

El archivo `balanceador-service.yaml` se ajusta para exponer el puerto mediante `NodePort`:

```yaml
spec:
  type: NodePort
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

Se aplica con:

```bash
kubectl apply -f balanceador-service.yaml
```

Y se accede vía navegador:

```
http://192.168.1.49:30080
```

📸 **Evidencia:**
![verificacion\_compose](assets/11.%20Comprobación%20del%20despliegue.png)

---

## ✅ Conclusión

Se ha logrado completar de forma satisfactoria el ciclo completo de despliegue en Kubernetes con **K3s**, incluyendo:

* 🟢 Creación de clúster single-node.
* 🔄 Conversión a entorno HA.
* 🐳 Integración de docker-compose en Kubernetes.
* 🖥️ Validación visual con `k9s` y pruebas de acceso reales.

Este entorno es útil como base para arquitecturas más complejas, integraciones con CI/CD y plataformas de monitorización.

---

## 📚 Referencias

* [https://k3s.io](https://k3s.io)
* [https://k9scli.io](https://k9scli.io)
* [https://kompose.io](https://kompose.io)
* [https://aulasoftwarelibre.github.io/taller-de-docker/dockerfile/#balanceo-de-carga](https://aulasoftwarelibre.github.io/taller-de-docker/dockerfile/#balanceo-de-carga)

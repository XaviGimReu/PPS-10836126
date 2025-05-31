# 📊 K3s + K9s: Despliegue y Validación en Entorno Kubernetes (RA5.4)

## 📖 Introducción

En esta práctica se ha desarrollado una arquitectura de despliegue y administración de contenedores utilizando **K3s**, una distribución ligera de Kubernetes, y **K9s**, una herramienta de terminal para gestionar clústeres Kubernetes.

La actividad está enfocada en la validación del entorno Kubernetes mediante tres enfoques clave:

* 🟢 Despliegue inicial en **modo single-node** con un servicio de nginx replicado.
  
* 🔄 Escalado del entorno a un clúster **HA (High Availability)**.
  
* 🧱 Despliegue a partir de un archivo `docker-compose` convertido a recursos Kubernetes mediante `Kompose`.


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

📸 **Instalación del clúster K3s en modo single-node:**


![instalacion_k3s](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_4/assets/1.%20Instalaci%C3%B3n%20k3s.png)

🛠 Se lanza el script oficial de instalación paraconfigurar el nodo maestro.



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

📸 **Definición y despliegue del Deployment de nginx:**
![deploy\_nginx](assets/2.%20Configuración%20y%20lanzamient%20de%20nginx.png)
📦 Se define un `Deployment` con 2 réplicas del contenedor `nginx`.

---

### 🔍 Verificación de los pods

Se comprueba que las dos réplicas de nginx estén en estado `Running`:

```bash
kubectl get pods
```

📸 **Comprobación de que los pods de nginx están corriendo:**
![verificacion\_nginx](assets/3.%20Verificación%20de%20lanzamiento.png)
🔎 Se valida visualmente el estado de los pods desplegados.

---

### 📥 Instalación y ejecución de K9s

Se utiliza K9s para una visualización en tiempo real del estado del clúster y sus recursos.

```bash
curl -sS https://webinstall.dev/k9s | bash
k9s
```

📸 **Instalación de la herramienta K9s:**
![instalacion\_k9s](assets/4.%20Instalación%20k9s.png)
🔧 Se descarga e instala la utilidad de administración K9s.

📸 **Vista del clúster desde la interfaz de K9s:**
![lanzamiento\_k9s](assets/5.%20Lanzamiento%20k9s.png)
🖥️ Visualización del entorno Kubernetes usando K9s.

---

## 🔹 5.2 Instalación y validación de K3s en modo HA

Este apartado busca convertir el clúster en un entorno **altamente disponible**, habilitando la opción `--cluster-init` para permitir la incorporación de nodos adicionales.

### 🛠 Instalación inicial en modo HA

```bash
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init" sh -
```

📸 **Inicio del clúster K3s en modo HA:**
![instalacion\_ha](assets/6.%20Instalación%20k3s%20\(HA\).png)
🔁 Se activa el modo `--cluster-init` para admitir múltiples nodos.

---

### 🔑 Obtención del token del nodo líder

Este token es necesario para que los nuevos nodos se unan al clúster:

```bash
sudo cat /var/lib/rancher/k3s/server/node-token
```

📸 **Token generado por el nodo principal del clúster:**
![token\_ha](assets/7.%20Token%20del%20nodo1.png)
🔐 Clave compartida para la autenticación entre nodos.

---

### 🌐 Simulación de unión de un nuevo nodo

Se documenta el comando de unión:

```bash
curl -sfL https://get.k3s.io | \
K3S_URL=https://192.168.1.49:6443 \
K3S_TOKEN=<TOKEN> sh -
```

📸 **Simulación de unión de un nodo agente al clúster:**
![union\_nodo](assets/8\(0\).%20Union%20otro%20nodo.png)
🧩 Se documenta el comando utilizado para integrar nodos adicionales.

---

### 📦 Despliegue del servicio nginx (modo HA)

El mismo manifiesto de despliegue se aplica en el clúster HA:

```bash
kubectl apply -f ha_nginx_deployment.yml
```

📸 **Aplicación del Deployment en el clúster HA:**
![deploy\_ha](assets/8.%20Despliegue%20ha_nginx_deployment.yml.png)
📄 Se despliega nginx en alta disponibilidad con 2 réplicas.

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

📸 **Definición del stack docker-compose a convertir:**
![compose\_file](assets/9.%20docker-compose.yml.png)
📑 Contiene 2 servicios nginx y un balanceador expuesto en el puerto 8080.

---

### 🔁 Conversión a manifiestos Kubernetes con Kompose

```bash
kompose convert
```

Esto genera los archivos YAML necesarios para cada servicio y su deployment correspondiente.

📸 **Conversión automática de docker-compose a Kubernetes:**
![kompose\_convert](assets/10.%20Despliegue%20de%20docker-compose.png)
⚙️ Kompose crea los `Deployment` y `Service` de cada contenedor definido.

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

📸 **Acceso y verificación del balanceador desde navegador:**
![verificacion\_compose](assets/11.%20Comprobación%20del%20despliegue.png)
🌐 Se valida la respuesta HTTP a través del puerto expuesto 30080.

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

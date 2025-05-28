# 📈 Prometheus + Grafana: Monitorización Dockerizada (RA5.3)

## 📖 Introducción

En esta práctica se ha desarrollado un stack de **monitorización** utilizando **Prometheus** y **Grafana**, con un enfoque en la detección y visualización de métricas desde contenedores y servidores remotos.

La actividad está dividida en dos fases:

* ✅ Despliegue de un stack local usando `docker-compose`.
* ✅ Monitorización remota de un servidor Ubuntu real desde un cliente Ubuntu 24.10.


## 📌 Prácticas Implementadas

📂 **Monitorización con Prometheus + Grafana:**

* 🔹 **Stack Docker Compose** – 🐳 *Prometheus, Grafana, cAdvisor, Alertmanager, Node Exporter, Node App*
* 🔹 **Monitorización Remota** – 📡 *Servidor Ubuntu con Prometheus y Node Exporter, Cliente con Grafana*

---

# 🧪 Actividades

## 🔹 3.1. Validación del Stack Dockerizado

### ✅ Servicios incluidos:

* Prometheus
* Grafana
* Node Exporter
* cAdvisor
* Alertmanager
* Node App

### 🧱 Configuración Prometheus

Se configuró el archivo `prometheus.yml` para definir el job `prometheus` y gestionar la integración con otros servicios del stack:

📸 **Archivo prometheus.yml:**
![prometheus\_config](assets/1.png)

---

### 🐳 Despliegue del stack con Docker Compose

Se ejecutó:

```bash
docker compose build
docker compose up -d
```

📸 **Salida del build y arranque de contenedores:**
![docker\_compose\_build](assets/2.png)

📸 **Servicios en estado Running:**
![docker\_services\_up](assets/2.png)

---

### 📊 Validación de servicios

📸 **Consulta PromQL en Prometheus:**
![prometheus\_query](assets/3.png)

📸 **Acceso a cAdvisor en localhost:8080:**
![cadvisor](assets/4.png)

📸 **Interfaz de inicio de Grafana (localhost:3000):**
![grafana\_inicio](assets/5.png)

---

## 🔹 3.2. Monitorización de Infraestructura Real

### 🖥️ Servidor (Ubuntu Server - 192.168.1.74)

* Instalación manual de Prometheus y Node Exporter.
* Configuración de `prometheus.yml` para apuntar a `node_exporter`:

  ```yaml
  scrape_configs:
    - job_name: 'node_exporter'
      static_configs:
        - targets: ['localhost:9100']
  ```
* Ajuste de Prometheus para escuchar en todas las interfaces:

  ```bash
  --web.listen-address="0.0.0.0:9090"
  ```
* Habilitación de puertos:

  ```bash
  sudo ufw allow 9090/tcp
  sudo ufw allow 9100/tcp
  ```

📸 (Agregar capturas de: `systemctl status`, `curl`, `prometheus.yml`)

---

### 🖥️ Cliente (Ubuntu 24.10 - Anfitrión)

* Se utilizó Grafana desde Docker Compose (ya desplegado).
* Se añadió el servidor Prometheus remoto como datasource:

  * URL: `http://192.168.1.74:9090`
* Se importó el dashboard oficial de Node Exporter (ID: `1860`).

📸 (Agregar captura de: configuración datasource, dashboard cargado con datos)

---

### 🌐 Comprobaciones de red

* Verificación de accesibilidad de puertos desde el cliente:

  ```bash
  curl http://192.168.1.74:9100/metrics
  curl http://192.168.1.74:9090/targets
  ```

---

## ✅ Conclusión

Se ha implementado con éxito un sistema de monitorización completo y funcional usando Prometheus y Grafana. El entorno dockerizado ha permitido validar la arquitectura y posteriormente se ha logrado monitorizar un servidor real de forma remota y segura desde el cliente.

> 🧩 Listo para ser extendido con reglas de alertas, integración con Loki y visualización de logs, o ampliación con servicios adicionales.

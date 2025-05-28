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


![prometheus.yml](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/1.%20prometheus.yml%20.png)

🔧 Configuración del `prometheus.yml` donde se define el job `prometheus` y los parámetros básicos de scraping.

---

### 🐳 Despliegue del stack con Docker Compose

Se ejecutó:

```bash
docker compose build
docker compose up -d
```

📸 **Salida del build y arranque de contenedores:**


![docker_compose](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/2.%20docker%20compose.png)

✅ Docker construye la imagen y levanta los contenedores correctamente sin errores.

---

### 📊 Validación de servicios

Comprobaremos que todos los servicios estén funcionando correctamente

📸 **Prometheus:**


![prometheus](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/3.%20prometheus.png)


📸 **cAdvisor:**


![cAdvisor](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/4.%20cAdvisor.png)


📸 **Grafana:**


![grafana](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/5.%20Grafana.png)

🟢 Todos los servicios aparecen en estado `Running` incluyendo **Prometheus**, **Grafana** y **Node Exporter**.

---

## 🔹 3.2. Monitorización de Infraestructura Real

### 💻 Servidor (Ubuntu Server - 192.168.1.74)

La primera configuración a realizar en nuestro serviddor **Ubuntu Server 24.04** será instalar `Prometheus` mediante los siguientes comandos:

```bash
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus /var/lib/prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz
tar -xvzf prometheus-*.tar.gz
sudo cp prometheus-*/prometheus /usr/local/bin/
```

📸 **Instalación de Prometheus:**


![instalacion_prometheus](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/6.%20instalaci%C3%B3n%20prometheus.png)

📉 Se descarga e instala Prometheus en el servidor, extrayendo el binario desde el tarball oficial y preparándolo para su ejecución.


Posteriormente, instalaremos `Node Exporter`, un componente de `Prometheus` que nos permitirá exponer las métricas del SO:

```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz
tar -xvzf node_exporter-*.tar.gz
sudo cp node_exporter-*/node_exporter /usr/local/bin/
```

📸 **Instalación de Node Exporter:**


![instalacion_node_exporter](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/7.%20instalaci%C3%B3n%20node_exporter.png)

🔧 Instalación manual de `node_exporter` en el servidor Ubuntu para exportar métricas del sistema.


Una vez instalados los servicios, configuraremos `Node Exporter` de la siguiente manera (`/etc/systemd/system/node_exporter.service`):

```mysql
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=prometheus
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
```

📸 **Configuración del servicio Node Exporter `(systemd)`:**


![configuracion_node_exporter](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/8.%20configuraci%C3%B3n%20node_exporter.png)

🔢 Se crea una unidad de servicio systemd para ejecutar Node Exporter al inicio del sistema.


Por último, comprobaremos el **estado del servicio** `Node Exporter`:

```bash
sudo systemctl daemon-reexec
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
sudo systemctl status node_exporter
```

📸 **Estado del servicio Node Exporter:**


![estado_node_exporter](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/9.%20estado%20de%20los%20servicios.png)

🟢 El servicio aparece como `active (running)` y habilitado para arrancar de forma automática.

---

### 💻 Cliente (Linux Mint - 192.168.1.57)

Al igual que en el **Ubuntu Server 24.04**, instalaremos `Prometheus` en nuestro equipo cliente.

Posteriormente, instalaremos `Grafana` en nuestro equipo cliente mediante los siguientes comandos:

```bash
sudo apt install -y software-properties-common
sudo add-apt-repository "deb https://apt.grafana.com stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt update
```

Cuando acabemos este proceso, iniciaremos `Grafana` en nuestro navegador y crearemos un nuevo `datasource` para añadir a nuestro **Prometheus** para poder monitorizarlo.

📸 **Configuración de `datasource` Prometheus en Grafana:**

![datasource_prometheus](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/10.%20vinculaci%C3%B3n%20de%20prometheus%20con%20grafana.png)

🔌 Se establece la conexión hacia la IP del servidor Prometheus (`192.168.1.74:9090`).


Cuando creemos el `datasource`, sabremos si lo hemos hecho correctamente al ver la verificación de la `API`.


📸 **Confirmación API:**

![api_ok](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/11.%20API.png)

📅 Grafana logra conectarse exitosamente con la API de Prometheus y puede comenzar a importar métricas.


Una vez creado correctamente el `datasource` en **Grafana**, importaremos un `dashboard` para poder ver todas las estadísticas de nuestro **Prometheus**.

📸 **Importación de Dashboard Prometheus:**


![import_dashboard](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/12.%20importaci%C3%B3n%20prometheus%20dashborad.png)

📅 Se importa desde Grafana.com el dashboard oficial de Prometheus (por `rfmoz`) para su visualización.

---

🖥️📔 **Visualización de paneles:**

Comprobaremos el funcionamiento de la monitorización de **Grafana** seleccionando diferentes parámetros

📸 **Monitorización de la CPU:**


![dashboard_1](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/13.%20prometheus%20dashboard_1.png)

📊 Panel de tipo `Time series` con la métrica `process_cpu_seconds_total` mostrando el uso de CPU del sistema.


📸 **Monitorización de la memoria RAM:**


![dashboard_2](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_3/assets/14.%20prometheus%20dashboard_2.png)

📊 Panel de tipo `Pie chart` con la métrica `process_virtual_memory_bytes` para comparar el uso de memoria entre servicios.


---


## ✅ Conclusión

Se ha implementado con éxito un sistema de monitorización completo y funcional usando Prometheus y Grafana. El entorno dockerizado ha permitido validar la arquitectura y posteriormente se ha logrado monitorizar un servidor real de forma remota y segura desde el cliente.

---

## 📬 Referencias

* [assets](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA5/RA5_3/assets)

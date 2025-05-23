 # 🌱 Terraform + Ansible: Provisión y Configuración Automática

## 📚 Introducción

En esta práctica se ha llevado a cabo la automatización del aprovisionamiento y configuración de una máquina virtual Ubuntu 24.04 utilizando **Terraform** (a través de Vagrant) y **Ansible**.

El objetivo principal es demostrar la capacidad de automatizar:

* La **creación de una máquina virtual Ubuntu**.
  
* La **configuración de red** y recursos hardware.
 
* La **instalación y configuración de Apache2**.
 
* La **verificación del despliegue** mediante un `curl`.



## 📂 Archivos del proyecto

* `Vagrantfile`: definición de infraestructura para Terraform (vía Vagrant)
  
* `inventory.ini`: inventario estático de Ansible
  
* `playbook_update_apache.yml`: actualización del sistema e instalación de Apache
  
* `playbook_index_html.yml`: despliegue de contenido web y validación final
  
* Capturas: disponibles en el directorio `assets/` del repositorio

---

## 🎯 3.1. Provisionar una máquina virtual Ubuntu 24.04 en Virtualbox mediante Terraform

En este caso, se utilizó un `Vagrantfile` para definir la infraestructura, esto se debe a que **Terraform** no fue del todo compatible con el sistema ni la versión 24.04 de Ubuntu requerida.

Por esto, emplearemos la herramienta **Vagrant** para crear una máquina virtual **Ubuntu 22.04**.

**Contenido del `Vagrantfile`:**

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64" # Ubuntu 24.04
  config.vm.hostname = "ubuntu2204"
  config.vm.network "private_network", ip: "192.168.56.10"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end
end
```

**Ejecución del despliegue:**

```bash
vagrant up
```

📸 **Captura de `vagrant up`:**


![vagrant up_1](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/assets/1.%20vagrant%20up.png)
![vagrant up_2](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/assets/2.%20vagrant%20up_2.png)

✅ **Vagrant** crea y arranca correctamente la máquina virtual Ubuntu 22.04 en VirtualBox.

Posteriormente, verificaremos que la máquina virtual se haya creado correctamente en **VirtualBox**.

📸 **Captura de la máquina corriendo en VirtualBox:**


![maquina corriendo](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/assets/3.%20m%C3%A1quina%20virutal.png)

✅ La máquina aparece en **VirtualBox** como "Corriendo" y con los parámetros asignados.

---

## 🎯 3.2. Configurar una máquina virtual Ubuntu 24.04 en VirtualBox mediante Ansible

Fichero de inventario `inventory.ini`:

```ini
[ubuntu]
192.168.56.10 ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/default/virtualbox/private_key ansible_connection=ssh
```

Playbook `playbook_update_apache.yml`:

```yaml
---
- name: Actualizar sistema e instalar Apache
  hosts: ubuntu
  become: yes
  tasks:
    - name: Update y upgrade del sistema
      apt:
        update_cache: yes
        upgrade: dist

    - name: Instalar Apache
      apt:
        name: apache2
        state: present
```

**Ejecución del playbook:**

```bash
ansible-playbook -i inventory.ini playbook_update_apache.yml
```

📸 **Captura de `update` & `upgrade` del sistema e instalación de Apache:**


![update apache](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/assets/4.%20playbook_update_apache.png)

✅ Se realiza `update`, `upgrade` e instalación del servicio `apache2` correctamente.

---

## 🎯 3.3. Crear un `index.html`, reiniciar el servicio y verificarlo mediante `curl`

Playbook `playbook_index_html.yml`

```yaml
---
- name: Crear index.html y reiniciar Apache
  hosts: ubuntu
  become: yes
  tasks:
    - name: Crear index.html
      copy:
        dest: /var/www/html/index.html
        content: "Ansible rocks"

    - name: Reiniciar Apache
      service:
        name: apache2
        state: restarted

    - name: Verificar el mensaje
      command: curl http://localhost
      register: resultado

    - name: Mostrar el resultado
      debug:
        var: resultado.stdout
```

**Ejecución del playbook:**

```bash
ansible-playbook -i inventory.ini playbook_index_html.yml
```

📸 **Captura de la creación de un indice que contenga `Ansible rocks`:**


![ansible rocks](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/assets/5.%20playbook_index_html.png)

✅ Se despliega correctamente la página web, reinicia Apache y `curl` muestra "Ansible rocks" como resultado.

---

## ✅ Conclusión

Esta práctica ha demostrado la capacidad de aprovisionar y configurar una infraestructura desde cero mediante herramientas de automatización como **Terraform (vía Vagrant)** y **Ansible**. Se han cumplido todos los requisitos de:

* Creación automatizada de máquina virtual.
* Instalación de Apache.
* Configuración de contenido web y validación de su funcionamiento.

Las capturas de pantalla incluidas en este documento sirven como evidencia de la correcta ejecución de cada una de las etapas de la actividad.

---

## 📂 Archivos del proyecto

* `Vagrantfile`: definición de infraestructura para Terraform (vía Vagrant)
* `inventory.ini`: inventario estático de Ansible
* `playbook_update_apache.yml`: actualización del sistema e instalación de Apache
* `playbook_index_html.yml`: despliegue de contenido web y validación final
* Capturas: disponibles en el directorio `assets/` del repositorio

---


---

## 📬 Referencias
**[assets](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA5/RA5_2/assets)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Vagrantfile](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/Vagrantfile)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[inventory-ini](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/inventory.ini)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[playbook_index_html.yml)](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/playbook_index_html.yml)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[playbook_update_apache.yml](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/playbook_update_apache.yml)**

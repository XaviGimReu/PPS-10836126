 # 🌱 Terraform + Ansible: Provisión y Configuración Automática

## 📖 Introducción

En esta práctica se implementa una solución de automatización completa utilizando **Terraform**, **Vagrant** y **Ansible** para el despliegue y configuración de una máquina virtual Ubuntu en VirtualBox.

Se trata de la **RA5.2**, centrada en la provisión de infraestructura y configuración de servicios.

---

## 3.1. Provisionar una máquina virtual Ubuntu 24.04 en Virtualbox mediante Terraform

Se ha utilizado **Vagrant** como proveedor dentro de **Terraform** para gestionar la creación de una máquina Ubuntu 24.04 (imagen `ubuntu/jammy64`).

📂 **Archivo**:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"  # Ubuntu 22.04/24.04
  config.vm.hostname = "ubuntu2204"

  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end
end
```

📸 **Captura de la ejecución **\`\`** y VM creada:**

&#x20;&#x20;

---

## 3.2. Configurar una máquina virtual Ubuntu 24.04 en Virtualbox mediante Ansible

### 🔧 Objetivo

* Actualizar el sistema (update & upgrade)
* Instalar el servicio Apache automáticamente

📂 \*\*Archivo \*\*\`\`:

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

📂 \*\*Archivo \*\*\`\`:

```ini
[ubuntu]
192.168.56.10 ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/default/virtualbox/private_key ansible_connection=ssh
```

📸 **Ejecución y resultado del playbook:**

---

## 3.3. Configurar una máquina virtual Ubuntu 24.04 en Virtualbox mediante Ansible

### 🎯 Objetivo

* Crear un `index.html` con el contenido "Ansible rocks"
* Reiniciar Apache
* Verificar con `curl` que se muestre el contenido correctamente

📂 \*\*Archivo \*\*\`\`:

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

📸 **Resultado esperado (respuesta del **\`\`**)**:

---

## ✅ Conclusión

Con esta práctica se ha logrado automatizar completamente la provisión y configuración de una máquina virtual utilizando herramientas de infraestructura como código:

* ✅ **Terraform** + **Vagrant** para levantar la máquina
* ✅ **Ansible** para la configuración automatizada del sistema operativo y del servidor web

### ✔️ Checklist de entrega:

*

---

## 📬 Referencias
**[assets](https://github.com/XaviGimReu/PPS-10836126/tree/main/template-main/RA5/RA5_2/assets)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[Vagrantfile](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/Vagrantfile)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[inventory-ini](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/inventory.ini)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[playbook_index_html.yml)](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/playbook_index_html.yml)**&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
**[playbook_update_apache.yml](https://github.com/XaviGimReu/PPS-10836126/blob/main/template-main/RA5/RA5_2/playbook_update_apache.yml)**

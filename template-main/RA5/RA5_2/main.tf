terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "~> 0.2"
    }
  }
}

provider "virtualbox" {}

resource "virtualbox_vm" "ubuntu_vm" {
  name   = "ubuntu2204"
  image  = "ubuntu/jammy64"
  cpus   = 2
  memory = 2048

  network_adapter {
    type           = "hostonly"
    host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }

  ssh_username = "vagrant"
  ssh_password = "vagrant"
}

output "ip_address" {
  value = virtualbox_vm.ubuntu_vm.ipv4_address
}

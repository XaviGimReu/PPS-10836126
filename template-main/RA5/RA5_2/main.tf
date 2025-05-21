terraform {
  required_providers {
    vagrant = {
      source = "bmatcuk/vagrant"
      version = "0.4.0"
    }
  }
}

provider "vagrant" {}

resource "vagrant_vm" "ubuntu" {
  name  = "ubuntu2404"
  box   = "ubuntu/jammy64"

  memory = 2048
  cpus   = 2

  network {
    type = "private_network"
    ip   = "192.168.56.10"
  }

  synced_folder {
    host_path      = "."
    guest_path     = "/vagrant"
    create         = true
  }
}

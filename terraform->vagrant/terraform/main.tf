terraform {
  required_providers {
    vagrant= {
        source = "bpg/vagrant"
        version = "~> 2.0"
    }
  }
}

variable "box_name" {
    description = "ubuntu18"
    default = "ubuntu/bionic64"
}

variable "vm_hostname" {
    description = "Hostname de la VM"
    default = "devops lab"

}

variable "memory" {
    description = "RAM en MB"
    default = 4096  
}

variable "cpus" {
    description = "Cpus dedicadas"
    default = 2
  
}

resource "vagrant_box" "devops_vm" {
    source = var.box_name
    name = var.vm_hostname

    
    providers = {
        virtualbox = { 
            memory = var.memory
            cpus = var.cpus
        forwarded_ports = [
            {
                guest = 8080 
                host = 8080
            },
            {
                guest = 30080
                host = 30080
            },
            {
                guest = 30030
                host = 30030
            },
            {
                guest = 6443
                host = 6443
            }
        ]
        }
    }
}


terraform {
  required_version = ">= 1.0"
  
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }
    local = {
      source = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

resource "null_resource" "vagrant_vm" {
  triggers = {
    box      = var.vm_box
    hostname = var.vm_hostname
    memory   = var.vm_memory
    cpus     = var.vm_cpus
    ports    = jsonencode(var.forwarded_ports)
  }

  provisioner "local-exec" {
    command = <<-EOF
      echo "📦 Creando VM con Vagrant..."
      cd ${path.module}/..
      vagrant up --provider=virtualbox --provision
      echo "✅ VM creada"
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOF
      echo "🗑️ Eliminando VM..."
      cd ${path.module}/..
      if [ -f Vagrantfile ]; then
        vagrant destroy -f
        rm -f Vagrantfile
        rm -rf .vagrant
        echo "✅ VM eliminada"
      else
        echo "⚠️ No se encontró Vagrantfile, VM no existe"
      fi
    EOF
  }
}

resource "local_file" "vagrantfile" {
  depends_on = []
  
  content = templatefile("${path.module}/../vagrantfile.tpl", {
    box      = var.vm_box
    hostname = var.vm_hostname
    memory   = var.vm_memory
    cpus     = var.vm_cpus
    ports    = var.forwarded_ports
  })
  filename = "${path.module}/../Vagrantfile"  # Escribe en la carpeta padre
}

data "local_file" "ansible_playbook" {
  depends_on = [null_resource.vagrant_vm]
  filename   = var.ansible_playbook_path
  
  lifecycle {
    precondition {
      condition     = fileexists(var.ansible_playbook_path)
      error_message = "El playbook de Ansible no existe en: ${var.ansible_playbook_path}"
    }
  }
}

data "external" "vm_ip" {
  depends_on = [null_resource.vagrant_vm]

  program = ["bash", "-c", <<-EOF
    echo "{\"ip\": \"192.168.56.10\"}"
  EOF
  ]
}
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
      vagrant up --provider=virtualbox
      echo "✅ VM creada"
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOF
      echo "🗑️ Eliminando VM..."
      vagrant destroy -f
      echo "✅ VM eliminada"
    EOF
  }
}

resource "local_file" "vagrantfile" {
  depends_on = []
  
  content = templatefile("${path.module}/vagrantfile.tpl", {
    box      = var.vm_box
    hostname = var.vm_hostname
    memory   = var.vm_memory
    cpus     = var.vm_cpus
    ports    = var.forwarded_ports
  })
  filename = "${path.module}/Vagrantfile"
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
    cd "${path.module}"
    
    # Esperar hasta que la VM esté lista (máximo 30 segundos)
    for i in {1..30}; do
      if vagrant ssh-config &>/dev/null; then
        break
      fi
      sleep 1
    done
    
    IP=$(vagrant ssh-config 2>/dev/null | grep -i "HostName" | awk '{print $2}')
    
    if [ -z "$IP" ]; then
      IP="127.0.0.1"
    fi
    
    echo "{\"ip\": \"$IP\"}"
  EOF
  ]
}
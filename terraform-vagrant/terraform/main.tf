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
      vagrant up
      echo "✅ VM creada"
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
      command = <<-EOF
        echo "🗑️ Eliminando VM..."
        cd ${path.module}/..
        vagrant global-status | grep "terraform-vagrant" | awk '{print $1}' | xargs -I{} vagrant destroy -f {}
        rm -f Vagrantfile
        rm -rf .vagrant
        echo "✅ VM eliminada"
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
data "external" "vm_ip" {
  depends_on = [null_resource.vagrant_vm]

  program = ["bash", "-c", <<-EOF
    echo "{\"ip\": \"192.168.56.10\"}"
  EOF
  ]
}
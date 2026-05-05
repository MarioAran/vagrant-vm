output "vm_ip" {
  value = data.external.vm_ip.result["ip"]
}

output "jenkins_url" {
  value = "http://${data.external.vm_ip.result["ip"]}:8080"
}

output "wordpress_url" {
  value = "http://${data.external.vm_ip.result["ip"]}:30080"
}

output "grafana_url" {
  value = "http://${data.external.vm_ip.result["ip"]}:30030"
}

output "jenkins_password_command" {
  description = "Obtener contraseña de Jenkins"
  value       = "vagrant ssh -c 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword'"
}

output "summary" {
  value = <<-EOT
    ┌─────────────────────────────────────────────┐
    │           ACCESOS DE LA VM                  │
    ├─────────────────────────────────────────────┤
    │ Jenkins:     http://192.168.56.10:8080
    │ WordPress:   http://192.168.56.10:30080
    │ Grafana:     http://192.168.56.10:30030
    │ K3s API:     https://192.168.56.10:6443
    │ SSH:         ssh vagrant@192.168.56.10
    └─────────────────────────────────────────────┘
  EOT
}


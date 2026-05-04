# outputs.tf

output "jenkins_url" {
  description = "URL Jenkins"
  value       = "http://${data.external.vm_ip.result["ip"]}:8080"
}

output "wordpress_url" {
  description = "URL WordPress"
  value       = "http://${data.external.vm_ip.result["ip"]}:30080"
}

output "grafana_url" {
  description = "URL Grafana"
  value       = "http://${data.external.vm_ip.result["ip"]}:30030"
}

output "k3s_api_url" {
  description = "API de K3s (Kubernetes)"
  value       = "https://${data.external.vm_ip.result["ip"]}:6443"
}

output "ssh_command" {
  description = "Conectar por SSH"
  value       = "ssh -p 2222 vagrant@${data.external.vm_ip.result["ip"]}"
}

output "kubectl_command" {  # ✅ Corregido: añadida la 'l'
  description = "Comando kubectl para K3s"
  value       = "kubectl --kubeconfig <(vagrant ssh -c 'sudo cat /etc/rancher/k3s/k3s.yaml') get nodes"
}

output "jenkins_password_command" {
  description = "Obtener contraseña de Jenkins"
  value       = "vagrant ssh -c 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword'"
}

output "summary" {
  description = "Resumen de todos los accesos"
  value = <<-EOT
    ┌─────────────────────────────────────────────┐
    │           ACCESOS DE LA VM                  │
    ├─────────────────────────────────────────────┤
    │ Jenkins:     http://${data.external.vm_ip.result["ip"]}:8080
    │ WordPress:   http://${data.external.vm_ip.result["ip"]}:30080
    │ Grafana:     http://${data.external.vm_ip.result["ip"]}:30030
    │ K3s API:     https://${data.external.vm_ip.result["ip"]}:6443
    │ SSH:         ssh -p 2222 vagrant@${data.external.vm_ip.result["ip"]}
    └─────────────────────────────────────────────┘
  EOT
}
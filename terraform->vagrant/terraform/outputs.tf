output "jenkins_url" {
    description = "url jenkins"
    value       = "http:////${data.external.vm_ip.result["ip"]}:8080"
}
output "wordpress_url" {
    description = "url wordpress"
    value       = "http:////${data.external.vm_ip.result["ip"]}:30080"
}
output "grafana_url" {
    description = "url grafana"
    value       = "http:////${data.external.vm_ip.result["ip"]}:30030"
}
output "k3s_api_url" {
    description = "API de K3s (Kubernetes)"
    value       = "https://${data.external.vm_ip.result["ip"]}:6443"
}

output "ssh_command" {
    description = "conectar por ssh"
    value       = "ssh -p ${data.external.vm_ip.result["port"]} vagrant@${data.external.vm_ip.result["ip"]}"
}

output "kubect_command" {
    description = "comando kubectl "
    value       = "kubectl --kubeconfig <(vagrant ssh -c 'sudo cat /etc/rancher/k3s/k3s.yaml') get nodes"
}

output "jenkins_password_command" {
    description = "contraseña de jenkins"
    value       = "vagrant ssh -c 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword'" 
}

output "summary" {
    description = "url a todos los acceso"
    value = <<-EOT
    ┌─────────────────────────────────────────────┐
    │           ACCESOS DE LA VM                  │
    ├─────────────────────────────────────────────┤
    │ Jenkins:     http://${data.external.vm_ip.result["ip"]}:8080
    │ WordPress:   http://${data.external.vm_ip.result["ip"]}:30080
    │ Grafana:     http://${data.external.vm_ip.result["ip"]}:30030
    │ K3s API:     https://${data.external.vm_ip.result["ip"]}:6443
    │ SSH:         ssh -p ${data.external.vm_ip.result["port"]} vagrant@${data.external.vm_ip.result["ip"]}
    └─────────────────────────────────────────────┘
  EOT
}
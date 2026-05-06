output "vm_ip" {
  value = data.external.vm_ip.result["ip"]
}

output "wordpress_url" {
  value = "http://${data.external.vm_ip.result["ip"]}:8000"
}


output "summary" {
  value = <<-EOT
    ┌─────────────────────────────────────────────┐
    │           ACCESOS DE LA VM                  │
    ├─────────────────────────────────────────────┤
    │ WordPress:   http://192.168.56.10:8000
    │ SSH:         ssh vagrant@192.168.56.10
    └─────────────────────────────────────────────┘
  EOT
}


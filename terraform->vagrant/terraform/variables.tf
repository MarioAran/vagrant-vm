variable "vm_box" {
    description = "box de vagrant a utilizar "
    type        = string
    default     = "ubuntu/bionic64"
}
variable "vm_hostname" {
    description = "hostname de la maquina"
    type        = string
    default     = "devops_lab"
}

variable "vm_memory" {
    description = "RAM dedicada"
    type = number
    default = 4096
}

variable "vm_cpus" {
    description = "cpus dedicadas"
    type = number
    default = 2  
}

variable "forwarded_ports" {
    description = "puertos redirigidos de la VM"
    type = list(object({
      guest = number
      host = number
    }))
  default = [ 
    {guest = 8080, host = 8080},    #jenkins
    {guest = 30080, host = 30080},  # wordpress
    {guest = 30030, host = 30030},  #grafana
    {guest = 6443, host = 6443},    #k3s API
  ]
}
variable "ansible_playbook_path" {
    description = "playbook de ansible"
    type = string
    default = "${path.module/ansible/playbook.yml}" 
}
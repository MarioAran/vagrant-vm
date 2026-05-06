<div align="center" id="top"> 
  <img src="./.github/app.gif" alt="Terraform Vagrant" />

  &#xa0;

  <!-- <a href="https://terraformvagrant.netlify.app">Demo</a> -->
</div>

<h1 align="center">Terraform Vagrant</h1>

<p align="center">
  <img alt="Terraform" src="https://img.shields.io/badge/terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white">
  <img alt="Vagrant" src="https://img.shields.io/badge/vagrant-1563FF?style=for-the-badge&logo=vagrant&logoColor=white">
  <img alt="Ansible" src="https://img.shields.io/badge/ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white">
  <img alt="Docker" src="https://img.shields.io/badge/docker-2496ED?style=for-the-badge&logo=docker&logoColor=white">
  <img alt="Wordpress" src="https://img.shields.io/badge/wordpress-21759B?style=for-the-badge&logo=wordpress&logoColor=white">
</p>

<!-- Status -->

<!-- <h4 align="center"> 
   WordPress con Docker + Terraform + Vagrant + Ansible
</h4> 

<hr> -->

<p align="center">
  <a href="#dart-about">About</a> &#xa0; | &#xa0; 
  <a href="#rocket-technologies">Technologies</a> &#xa0; | &#xa0;
  <a href="#white_check_mark-requirements">Requirements</a> &#xa0; | &#xa0;
  <a href="#checkered_flag-starting">Starting</a> &#xa0; | &#xa0;
  <a href="#memo-license">License</a> &#xa0; | &#xa0;
  <a href="https://github.com/MarioAran" target="_blank">Author</a>
</p>

<br>

## :dart: About ##

Este proyecto automatiza la creación de una VM y despliega WordPress usando Infraestructura como Código con **Terraform**, **Vagrant** y **Ansible**.


## :rocket: Technologies ##

The following tools were used in this project:
- [virtualbox (Hipervisor)](https://www.virtualbox.org/)
- [Terraform  (create VM)](https://developer.hashicorp.com/terraform)
- [Vagrant    (Manage VM)](https://developer.hashicorp.com/vagrant)
- [Ansible    (Provision)](https://docs.ansible.com/)
- [Docker     (run wordpress)](https://www.docker.com/)

## :white_check_mark: Requirements ##

you need to have 
- [Git        version "=> 2.37.1"](https://git-scm.com)
- [virtualbox version "=> 7.0.6"](https://www.virtualbox.org/wiki/Downloads)
- [terraform  version "=> 1.0"](https://developer.hashicorp.com/terraform/install)
- [Vagrant    version "=> 2.4.9"](https://developer.hashicorp.com/vagrant/install)
- [Ansible    version "=> 2.19.8"](https://docs.ansible.com/projects/ansible/latest/installation_guide/intro_installation.html#id12)
- [Docker     version "=> 24.0.6"](https://docs.docker.com/engine/install/)
- 

## 🏗️ Architecture
- mac 
-   ↓
- Terraform → Vagrant → VirtualBox → VM Ubuntu 
-   ↓
- Ansible
-   ↓
- Docker

## :checkered_flag: Starting ##

```bash
# Clone this project
$ git clone https://github.com/MarioAran/vagrant-vm.git

# Access
$ cd terraform-vagrant

# init terraform
$ cd terraform
$ terraform init          # Inicializa el directorio y descarga los providers necesarios
$ terraform validate            # Valida que la sintaxis de los archivos sea correcta
$ terraform plan                 # Muestra los cambios que se van a realizar

# Run the project
$ terraform apply -auto-approve # Crea/modifica la infraestructura
# terraform creara una vm con virtualbox 

$ cd ../ansible/ 
$ ansible -i hosts.ini all  -m ping # hara un ping al servidor y devolvera un pong como respuesta a que se ha conectado correctamente 
$ ansible-playbook -i hosts.ini playbook.yml # se conectara con los hosts dentro del archivo y ejecuta el playbook configurandolo

# wordpress http://192.168.56.10:8000
```

## :memo: License ##

This project is under license from MIT. For more details, see the [LICENSE](LICENSE) file.


Made with :heart: by <a href="https://github.com/MarioAran" target="_blank">MarioAran</a>

&#xa0;

<a href="#top">Back to top</a>

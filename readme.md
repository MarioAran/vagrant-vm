# 🚀 Entornos Vagrant para Desarrollo Web

Este repositorio contiene dos entornos de desarrollo virtualizados con Vagrant:

1. **CentOS 7** - Servidor web con Apache y plantilla HTML/CSS
2. **Ubuntu 18.04** - Servidor WordPress con Docker y MySQL

## 📋 Requisitos previos

- [VirtualBox](https://www.virtualbox.org/) (≥ 6.0)
- [Vagrant](https://www.vagrantup.com/) (≥ 2.2)
- 4GB RAM disponible (2GB por máquina)
- Conexión a internet (para descargar boxes e imágenes)

## 🖥️ Entorno 1: CentOS 7 - Web Estática

### Características
- **Box:** `geerlingguy/centos7`
- **IP Privada:** `192.168.33.10`
- **Puertos:** `8080:80` (acceso local)
- **Software:** Apache, wget, unzip
- **Plantilla:** Exhibit Studio de Tooplate

### ¿Qué hace?
1. Configura repositorio Alibaba Cloud (CentOS 7 EOL)
2. Instala Apache, wget y unzip
3. Descarga y despliega plantilla web
4. Inicia y habilita Apache

### Acceso
```bash 
cd centos7-web/
vagrant up
```
# Abrir navegador: http://localhost:8080


## 🖥️ Entorno 2: Ubuntu 18 - Wordpress con docker 

### Características
- **Box:** `ubuntu/bionic64`
- **IP Privada:** `192.168.55.10`
- **Puertos:** `8080:8000` (acceso local)
- **Recursos:** 1600MB RAM, 2 CPUs
- **Contenedores:** WordPress + MySQL 8

### ¿Qué hace?
1. Instala Docker Engine y Docker Compose
2. Descarga docker-compose.yml desde GitHub
3. Corrige volúmenes (elimina dependencia de ~/Desktop/)
4. Levanta WordPress y MySQL

### Acceso
```bash
cd ubuntu-wordpress/
vagrant up
# Abrir navegador: http://localhost:8000


## 📁 Estructura del proyecto
```markdown
```bash
📦 tu-proyecto/
├── 📁 centos7-web/
│   └── 📄 Vagrantfile
├── 📁 ubuntu-wordpress/
│   └── 📄 Vagrantfile
└── 📄 README.md

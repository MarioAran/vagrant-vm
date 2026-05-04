# vagrantfile.tpl
Vagrant.configure("2") do |config|
  config.vm.box = "${box}"
  config.vm.hostname = "${hostname}"

  # Red privada con IP fija (para acceso consistente)
  config.vm.network "private_network", ip = "192.168.56.10"

  # Puertos redirigidos (acceso desde localhost)
%{ for port in ports ~}
  config.vm.network "forwarded_port", guest: ${port.guest}, host: ${port.host}
%{ endfor ~}

  # Configuración de VirtualBox
  config.vm.provider "virtualbox" do |vb|
    vb.memory = ${memory}
    vb.cpus = ${cpus}
    vb.name = "${hostname}"
  end

  # Aprovisionamiento con Ansible
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/playbook.yml"
    ansible.verbose = false
    ansible.compatibility_mode = "2.0"
  end
end
# vagrantfile.tpl
Vagrant.configure("2") do |config|
  config.vm.box = "${box}"
  config.vm.hostname = "${hostname}"

  config.vm.network "private_network", ip: "192.168.56.10"

%{ for port in ports ~}
  config.vm.network "forwarded_port", guest: ${port.guest}, host: ${port.host}
%{ endfor ~}

  config.vm.provider "virtualbox" do |vb|
    vb.memory = ${memory}
    vb.cpus = ${cpus}
    vb.name = "${hostname}"
  end

  # Esperar más tiempo para que SSH esté listo
  config.vm.boot_timeout = 600
  config.ssh.insert_key = false

  # Shell script antes de Ansible
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update -y
    sudo apt-get install -y python3 python3-apt
    sudo ln -sf /usr/bin/python3 /usr/bin/python
  SHELL

  # Ansible provisioner
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/playbook.yml"
    ansible.verbose = "vvv"
    ansible.compatibility_mode = "2.0"
    ansible.host_key_checking = false
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3",
      ansible_ssh_extra_args: "-o ConnectTimeout=60"
    }
  end
end
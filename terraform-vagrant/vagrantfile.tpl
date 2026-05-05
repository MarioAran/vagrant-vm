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
end
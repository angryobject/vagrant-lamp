Vagrant::Config.run do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Assign an IP address to VM
  # If you change it here - you should update
  # manifests/default.pp and conf/mysql/my.cnf
  config.vm.network :hostonly, "192.168.50.4"

  # Enable the Puppet provisioner
  config.vm.provision :puppet
end

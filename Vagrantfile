Vagrant::Config.run do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Apache port forwarding
  config.vm.forward_port 80, 4567

  # MySQL port forwarding
  config.vm.forward_port 4568, 4568

  # Enable the Puppet provisioner
  config.vm.provision :puppet
end
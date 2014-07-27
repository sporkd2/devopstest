# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "devopstest"
  config.vm.box_url = "http://www.lyricalsoftware.com/downloads/centos65.box"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "4096"]
  end
  config.vm.synced_folder "salt/", "/srv", owner: "root", group: "root"
  config.vm.hostname = "devopstest"
  config.vm.box_url = "http://www.lyricalsoftware.com/downloads/centos65.box"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
    salt.install_type = "git"
    salt.install_args = "v2014.1.0"
    salt.verbose = true
  end
end

Vagrant.configure("2") do |config|
    config.vm.box_check_update = false
    config.vm.box = "ubuntu/focal64"
    config.vm.network "private_network", ip: "192.168.111.121"
    config.vm.hostname = "graylog-test.local"
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.provider "virtualbox" do |vb|
        vb.name = "graylog-test.local"
        vb.memory = 4096
        vb.gui = false
    end
  end
  
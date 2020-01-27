Vagrant.configure("2") do |config|

    config.vm.box = "etable/bionic64"
    config.vm.box_version = "20191212"
    config.vm.box_download_insecure = true

    config.vm.provider "virtualbox" do |vb|
        vb.name = "dockerfile-build-test"
        
        vb.memory = 1512
        vb.cpus = 1
        
        vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
    end

    config.vm.network "private_network", ip: "192.168.10.111"
    config.vm.network "forwarded_port", guest: 22, host: 3223

    config.vm.synced_folder "./.", "/home/vagrant/code"

    config.vm.provision :shell, :path => "./vagrant/provision/provision-docker.sh"
    config.vm.provision :shell, :path => "./vagrant/provision/provision-supervisor.sh"

end
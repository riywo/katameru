Vagrant::Config.run do |conf|
  conf.vm.define :"ubuntu-12.04-64" do |config|
    config.vm.host_name = "ubuntu-12.04-64"
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    config.vm.network :hostonly, "192.168.110.111"
    config.vm.customize ["modifyvm", :id, "--memory", 512]
    config.vm.customize ["modifyvm", :id, "--cpus", 4]
  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
test -d /srv/pillar || sudo mkdir /srv/pillar
test -f /tmp/travis/top.sls && sudo cp /{tmp/travis,srv/salt}/top.sls
sudo cp {/tmp/travis,/srv/salt}/top.sls
sudo cp /tmp/travis/top_pillar.sls /srv/pillar/top.sls
sudo cp /srv/{salt/pillar.example,pillar/openvas.sls}
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.define "xenial" do |xenial|
    xenial.vm.box = 'xenial'
  end

  # config.vm.define "jessie" do |jessie|
  #   jessie.vm.box = 'debian/jessie64'
  # end

  config.vm.define "kali" do |kali|
    kali.vm.box = 'kali-2016.1'
    kali.ssh.private_key_path = '../pentest-env/ssh-keys/pentest-env'
    kali.ssh.username = 'root'

    kali.vm.provider 'virtualbox' do |vb|
      vb.customize ['modifyvm', :id, '--memory', 2048]
    end
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/srv/salt"
  config.vm.synced_folder ".travis", "/tmp/travis"

  config.vm.provision :shell, inline: $script
  config.vm.provision :salt do |salt|
    salt.bootstrap_script = "../salt-bootstrap/bootstrap-salt.sh"
    salt.bootstrap_options = "-d"
    # salt.install_type = "git"
    salt.masterless = true
    salt.minion_config = ".travis/minion"
    salt.run_highstate = true
    salt.colorize = true
    salt.verbose = true
    salt.log_level = "warning" 
  end
end

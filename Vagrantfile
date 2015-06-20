# -*- mode: ruby -*-
# vi: set ft=ruby :

## @author: Abhishek Dev
## @date: 14-May-2014

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "abhishekdev/centos-65-x64-puppet"
  config.vm.hostname = "jantos.example.com"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 8443, host: 8443, auto_correct: true
  config.vm.network "forwarded_port", guest: 1521, host: 1521, auto_correct: true
  config.vm.network "forwarded_port", guest: 15210, host: 15210, auto_correct: true

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.
  config.vm.provider "virtualbox" do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id,
                  # Name to show in virtualbox
                  "--name", "Jantos",
                  # Use 1024+ when using OracleXE (Oracle Database XE database uses cannot exceed 1 gigabyte, even if more is available.)
                  # NOTE: Adjust accordingly if deployed applications need more memory
                  "--memory", "1024"]
  end

  # Bootstrap basic environment using shell
  config.vm.provision "shell", path: "shell/bootstrap.sh"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end
  config.vm.provision :puppet do |puppet|
    puppet.module_path    = "puppet/modules"
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "base.pp"
    puppet.options        = "--verbose"
    puppet.facter = {
      "directory_bin"       => "/vagrant/bin",
      "directory_install"   => "/vagrant/install",

      # Set timezone
      # Sample:  US/Eastern, EST5EDT, Asia/Calcutta, America/Los_Angeles
      "timezone" => 'UTC',

      # Set package versions. Some packages use OS package managers,
      # while some are configured manually. Supported version values
      # for packages which do not use OS package managers are listed below:
      #  - Java [6] You may enable it in ./puppet/manifests/base.pp
      #  - Java [7, 8]
      #  - Ant [1.6, 1.7, 1.8, 1.9]
      #  - Tomcat [7, 8]
      "v_jdk"         => "8",
      "v_ant"         => "1.9",
      "v_node"        => "0.12.4",
      "v_tomcat"      => "7",
      "v_oracle"      => "11gXE",
      "v_subversion"  => "latest",
    }
  end

end

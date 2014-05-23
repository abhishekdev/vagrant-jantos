vagrant-jantos
==============

Java Ant Node Tomcat Oracle Subversion on CentOS using [Vagrant](http://www.vagrantup.com) and headless VirtualBox
> :exclamation: This is a work in progress


## Default Add-ons:
- Subversion: latest (v1.8.9+)
- Node.js: latest (v0.10.26+)
- Java
	- JDK 6 update 45
- Tomcat
	- Tomcat 7.0.53


## Requirements
* Install VirtualBox from [virtualbox.org](https://www.virtualbox.org)
* Install Vagrant from [vagrantup.com](http://www.vagrantup.com)
* An internet connection is required to provision the box for the first time
* If JDK6 needs to be installed
	
	- Download Sun Java JDK 6 ( update 45 ) from [here](http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-javase6-419409.html#jdk-6u45-oth-JPR). Use the jdk-6u*-linux-x64-rpm.bin file.
	- Put it in the folder `[projectroot]/tools/install/java/` (Create directories if required)
	
* For Windows Hosts:
	- Ensure that you have VirtualBox directory in your `%PATH%`. Usually `Program Files\Oracle\VirtualBox` for deafult installs
	- To use ssh on Windows OS, install ssh client like Cygwin, MinGW or Git, all of which contain an SSH client. Or use PuTTY SSH client the following authentication information:
```
Host: 127.0.0.1
Port: 2222
Username: vagrant
```


## Installation
* Check out this project:

        git clone https://github.com/abhishekdev/vagrant-jantos.git

* Install [vbguest]:

        vagrant plugin install vagrant-vbguest

* [Optional] Tweak configurations in `[projectroot]/Vagrantfile`, `[projectroot]/puppet/manifests/base.pp`

* Boot the machine from project root.
		
		vagrant up


## TODO:
- [x] Host Vagrant box on a file Server
- [x] Add SVN Support
- [x] Add Node Support
- [x] Add Java Support
- [x] Add Tomcat Support
- [ ] Add Ant Support
- [ ] Add Oracle Support
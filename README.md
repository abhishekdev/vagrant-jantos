vagrant-jantos
==============

Java Ant Node Tomcat Oracle Subversion on CentOS using [Vagrant](http://www.vagrantup.com) and headless VirtualBox
> :exclamation: This is a work in progress


## Default Add-ons:
- Subversion: latest (v1.8.9+)
- Node.js: latest (v0.10.26+)


## Instructions:
* Install VirtualBox from [virtualbox.org](https://www.virtualbox.org)
* Install Vagrant from [vagrantup.com](http://www.vagrantup.com)
* [Optional] Tweak configurations in */Vagrantfile*, */puppet/manifests/base.pp*
* Run `vagrant up` from project root


### TODO:
- [x] Host Vagrant box on a file Server
- [x] Add SVN Support
- [x] Add Node Support
- [ ] Add Java Support
- [ ] Add Tomcat Support
- [ ] Add Ant Support
- [ ] Add Oracle Support
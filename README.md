
Jantos on CentOS using Vagrant
==============================

(Java Ant Node Tomcat Oracle Subversion) on CentOS using [Vagrant](http://www.vagrantup.com) and headless VirtualBox



## Default Add-ons:
- Subversion: latest (v1.8.9+)
- Node.js: v0.12.4
- Java: JDK 8 update 45
- Tomcat: 7.0.53
- Ant: 1.9.5
- Oracle: Express Edition 11g Release 2 :arrow_down:

:arrow_down: : Requires manual download, see requirements section below


## Requirements
* Install VirtualBox from [virtualbox.org](https://www.virtualbox.org)
* Install Vagrant from [vagrantup.com](http://www.vagrantup.com)
* An internet connection is required to provision the box for the first time
* If JDK6 needs to be installed
	
	- Download Sun Java JDK 6 ( update 45 ) from [here](http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-javase6-419409.html#jdk-6u45-oth-JPR). Use the jdk-6u*-linux-x64-rpm.bin file.
	- Put it in the folder `[projectroot]/install/java/` (Create directories if required)

* If Oracle needs to be installed
	
	- Download Oracle XE 11g from [here](http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html). Use the oracle-xe-11.2.0-1.0.x86_64.rpm.zip file
	- Put in `[projectroot]/install/oracle/` (Create directories if required)
	
* For Windows Hosts:
	- Ensure that you have VirtualBox directory in your `%PATH%`. Usually `Program Files\Oracle\VirtualBox` for default installations
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


## How To

### Use the VM
- Connect to the new machine from the project root
	
        vagrant ssh	

- If required, password for `root` is `vagrant`

### Connect to Oracle
Connect to Oracle using [SQL Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html) at `localhost:1521/XE` as `system` with password `manager`. 
e.g. if you have `sqlplus` installed on the host machine you may connect with:

         sqlplus system/manager@//localhost:1521/XE

### Use Tomcat
- Connect to the machine using `vagrant ssh`
- Startup Tomcat using the command `$CATALINA_HOME/bin/startup.sh`
- Shutdown Tomcat using the command `$CATALINA_HOME/bin/shutdown.sh`


## TODO
- [ ] Setup tomcat as a service OR a command
- [ ] Parametrize credentials for Oracle/Tomcat Admin

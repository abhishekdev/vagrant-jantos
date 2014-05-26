# Configure Machine
# @author Abhishek Dev
# @date 14-May-2014

node jantos{

	# Ensure the /vagrant/bin and /vagrant/install directories are present
	file{ ["$directory_install", "$directory_bin"]:
		ensure => 'directory',
	}

	# Turn off iptables (or any other Firewall)
	service { iptables:
		enable    => false,
		ensure    => false,
		hasstatus => true,
	}

	# -- Install SVN
	include subversion::client

	# -- Install Node.js
	include nodejs::platform

	# -- Install JDK6
	include java::jdk6

	# -- Install Tomcat
	Class['java::jdk6'] -> Class['apache::tomcat']
	include apache::tomcat

	# -- Install Ant
	Class['java::jdk6'] -> Class['apache::ant']
	include apache::ant

	# -- Install Oracle
	Class["oracle::server"] -> Class["oracle::xe"]
	include oracle::server
	include oracle::xe
	
}
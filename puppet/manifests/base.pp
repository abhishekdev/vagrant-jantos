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

	# -- Update time zone
	include timezone::custom

	# -- Install SVN
	include subversion::client

	# -- Update git
	include git::client

	# -- Install Node.js
	include nodejs::platform

	# -- Install JDK6
	# Uncomment the following line to install JDK 6
	# Class['java::jdk6'] -> Class['java::jdk']
	# include java::jdk6

	# -- Install JDK7+
	include java::jdk

	# -- Install Tomcat
	Class['java::jdk'] -> Class['apache::tomcat']
	include apache::tomcat

	# -- Install Ant
	Class['java::jdk'] -> Class['apache::ant']
	include apache::ant

	# -- Install Oracle
	Class["oracle::server"] -> Class["oracle::xe"]
	include oracle::server
	include oracle::xe

}

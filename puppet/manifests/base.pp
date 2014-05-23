# Configure Machine
# @author Abhishek Dev
# @date 14-May-2014

node jantos{
	# -- Install SVN
	include subversion::client

	# -- Install Node.js
	include nodejs::platform

	# -- Install JDK6
	include java::jdk6

	# Turn off iptables (or any other Firewall)
	service { iptables:
		enable    => false,
		ensure    => false,
		hasstatus => true,
	}
}
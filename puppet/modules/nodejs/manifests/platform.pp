# Setup machine with nodejs & npm
# @author Abhishek Dev
# @date 14-May-2014

# Reference: https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#rhelcentosscientific-linux-6

class nodejs::platform {

	exec { "Import EPEL Key":
		command => '/bin/rpm --import https://fedoraproject.org/static/0608B895.txt',
		before => Package["epel-release"],
	}

	package { "epel-release":
	  ensure => '6-8',
	  provider => 'rpm',
	  source => 'http://download-i2.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm',
	  before => Package["nodejs"],
	}

	package { "nodejs":
		ensure => $v_node,
	}

	package { "npm":
		ensure => 'present',
		install_options => ['--enablerepo=epel'],
		require => Package['nodejs'],
	}

}
# Setup machine with nodejs & npm
# @author Abhishek Dev
# @date 14-May-2014

# Reference: https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#rhelcentosscientific-linux-6

class nodejs::platform {

	file { "${directory_install}/nodejs":
		ensure => "directory",
		before => Exec["Fetch Nodejs Installer"],
	}

	exec { "Fetch Nodejs Installer":
		command => "/usr/bin/wget -c http://nodejs.org/dist/v${v_node}/node-v${v_node}-linux-x64.tar.gz",
		path => "/bin",
		cwd => "${directory_install}/nodejs/",
	    creates => "${directory_install}/nodejs/node-v${v_node}-linux-x64.tar.gz",
	}

	exec { "Install Nodejs":
		command => "tar --strip-components 1 -xzvf node-v${v_node}-linux-x64.tar.gz -C /usr/local",
		cwd => "${directory_install}/nodejs/",
		path => ["/bin"],
		require => Exec["Fetch Nodejs Installer"],
	}

}

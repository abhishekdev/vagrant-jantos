# Setup machine with Apache ant
# @author Abhishek Dev
# @date 14-May-2014

class apache::ant {

	$base_name = $v_ant ? { 
		'1.6' => "apache-ant-1.6.5", 
		'1.7' => "apache-ant-1.2.1", 
		'1.8' => "apache-ant-1.8.4", 
		'1.9' => "apache-ant-1.9.5", 
		'default' => 'NA',
	}

	$installerSource = "http://archive.apache.org/dist/ant/binaries/${base_name}-bin.tar.bz2"


	file { "${directory_install}/ant":
		ensure => "directory",
		before => Exec["Fetch Ant Installer"],
	}

	file { "/vagrant/install/ant/${base_name}-bin.tar.bz2":
		ensure  => 'present',
		owner   => 'vagrant',
		before => Exec["Install Ant"],
		require => Exec["Fetch Ant Installer"],
	}

	exec{ "Fetch Ant Installer":
		command => "/usr/bin/wget $installerSource -O ${directory_install}/ant/${base_name}-bin.tar.bz2",
	    user => root,
	    path => '/bin',
	    creates => "${directory_install}/ant/${base_name}-bin.tar.bz2",
	}

	exec{ "Install Ant":
		command => "/bin/tar xjf ${directory_install}/ant/${base_name}-bin.tar.bz2 -C ${directory_bin} && /bin/mv ${directory_bin}/${base_name} ${directory_bin}/ant",
	    creates => "${directory_bin}/ant",
	}

	exec { "Set ANT_HOME":
		command => "echo export ANT_HOME=\"${directory_bin}/ant\" >> ~/.bash_profile",
		user => vagrant,
		unless => "echo $ANT_HOME | grep -c \"${directory_bin}/ant\"",
		path => ["/bin"],
		require => Exec["Install Ant"],
	}

	# Install Sun/Oracle JDK java, javaws, libjavaplugin.so (for Firefox/Mozilla) and javac with alternatives –install command
	exec {"Set ant command":
		command => "/usr/sbin/alternatives --install /usr/bin/ant ant ${directory_bin}/ant/bin/ant 20000",
		user => root,
		require => Exec["Install Ant"],
	}
	
}
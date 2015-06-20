# Setup machine with Tomcat
# @author Abhishek Dev
# @date 23-May-2014

class apache::tomcat {

	$installerSource = $v_tomcat ? { 
		'7' => ["http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.53/bin/apache-tomcat-7.0.53.tar.gz"], 
		'8' => ["http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.8/bin/apache-tomcat-8.0.8.tar.gz"], 
		'default' => 'NA',
	}

	$base_name = $v_tomcat ? { 
		'7' => "apache-tomcat-7.0.53", 
		'8' => "apache-tomcat-8.0.8", 
		'default' => 'NA',
	}

	file { "${directory_install}/tomcat/":
		ensure => directory,
		before => Exec["Fetch Tomcat Installer"],
	}

	file { "${directory_install}/tomcat/${base_name}.tar.gz":
		ensure  => 'present',
		owner   => 'vagrant',
		before => Exec["Install Tomcat"],
		require => Exec["Fetch Tomcat Installer"],
	}

	exec{ "Fetch Tomcat Installer":
		command => "/usr/bin/wget $installerSource -O ${directory_install}/tomcat/${base_name}.tar.gz",
	    user => root,
	    path => '/bin',
	    creates => "${directory_install}/tomcat/${base_name}.tar.gz",
	}

	exec{ "Install Tomcat":
		command => "tar xzf ${directory_install}/tomcat/${base_name}.tar.gz -C ${directory_bin} && /bin/mv ${directory_bin}/${base_name} ${directory_bin}/tomcat",
	    user => root,
	    path => ["/bin"],
	    creates => "${directory_bin}/tomcat",
	}

	exec { "Set CATALINA_HOME":
		command => "echo export CATALINA_HOME=\"${directory_bin}/tomcat\" >> ~/.bash_profile",
		user => vagrant,
		unless => "echo $CATALINA_HOME | grep -c \"${directory_bin}/tomcat\"",
		path => ["/bin"],
		require => Exec["Install Tomcat"],
	}

	# unlock tomcat admin-gui. Default login credentials: admin/password
	file { "${directory_bin}/tomcat/conf/tomcat-users.xml":
	    ensure => "present",
	    content => template('apache/tomcat-users.xml.erb'),
	    require => Exec["Install Tomcat"],
	}

	# copy keystore to bin
	file { "${directory_bin}/.keystore":
	    ensure => "present",
	    content => template('apache/keystore'),
	}

	# enable SSL on tomcat
	file { "${directory_bin}/tomcat/conf/server.xml":
	    ensure => "present",
	    content => template('apache/server.xml.erb'),
	    require => Exec["Install Tomcat"],
	}

}

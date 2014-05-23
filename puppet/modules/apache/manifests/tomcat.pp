# Setup machine with Tomcat
# @author Abhishek Dev
# @date 23-May-2014

class apache::tomcat {

	$installerSource = $tomcatversion ? { 
		'7' => ["http://www.eu.apache.org/dist/tomcat/tomcat-7/v7.0.53/bin/apache-tomcat-7.0.53.tar.gz"], 
		'8' => ["http://mirror.tcpdiag.net/apache/tomcat/tomcat-8/v8.0.8/bin/apache-tomcat-8.0.8.tar.gz"], 
		'default' => 'NA',
	}

	$base_name = $tomcatversion ? { 
		'7' => "apache-tomcat-7.0.53", 
		'8' => "apache-tomcat-8.0.8", 
		'default' => 'NA',
	}

	file { "${dev_installer_path}/tomcat/":
		ensure => directory,
		before => Exec["Fetch Tomcat Installer"],
	}

	file { $dev_bin:
		ensure => directory,
		before => Exec["Install Tomcat"],
	}

	file { "${dev_installer_path}/tomcat/${base_name}.tar.gz":
		ensure  => 'present',
		owner   => 'vagrant',
		before => Exec["Install Tomcat"],
		require => Exec["Fetch Tomcat Installer"],
	}

	exec{ "Fetch Tomcat Installer":
		command => "/usr/bin/wget $installerSource -O ${dev_installer_path}/tomcat/${base_name}.tar.gz",
	    user => root,
	    path => '/bin',
	    creates => "${dev_installer_path}/tomcat/${base_name}.tar.gz",
	}

	exec{ "Install Tomcat":
		command => "tar xzf ${dev_installer_path}/tomcat/${base_name}.tar.gz -C ${dev_bin} && /bin/mv ${dev_bin}/${base_name} ${dev_bin}/tomcat",
	    user => root,
	    path => ["/bin"],
	    creates => "${dev_bin}/tomcat",
	}

	exec { "Set CATALINA_HOME":
		command => "echo export CATALINA_HOME=\"${dev_bin}/tomcat\" >> ~/.bash_profile",
		user => vagrant,
		unless => "echo $CATALINA_HOME | grep -c \"${dev_bin}/tomcat\"",
		path => ["/bin"],
		require => Exec["Install Tomcat"],
	}
	
}
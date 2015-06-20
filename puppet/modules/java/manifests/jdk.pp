# Setup machine with Oracle Java SE
# @author Abhishek Dev
# @date 14-May-2014

# Reference: http://www.if-not-true-then-false.com/2010/install-sun-oracle-java-jdk-jre-6-on-fedora-centos-red-hat-rhel/

class java::jdk {

	$base_name = $v_jdk ? {
		'7' => "jdk-7u79",
		'8' => "jdk-8u45",
		'default' => 'NA',
	}

	$rel_path = $v_jdk ? {
		'7' => "7u79-b15",
		'8' => "8u45-b14",
		'default' => 'NA',
	}

	$target_name = $v_jdk ? {
		'7' => "jdk1.7.0_79",
		'8' => "jdk1.8.0_45",
		'default' => 'NA',
	}

	$installerSource = "http://download.oracle.com/otn-pub/java/jdk/${rel_path}/${base_name}-linux-x64.rpm"

	file { "/vagrant/install/java/${base_name}-linux-x64.rpm":
		ensure  => 'present',
		owner   => 'vagrant',
		before => Exec["Install Java JDK"],
		require => Exec["Fetch Java Installer"],
	}

	exec{ "Fetch Java Installer":
		command => "/usr/bin/wget -c --no-check-certificate --no-cookies --header \"Cookie: oraclelicense=accept-securebackup-cookie\" $installerSource -O ${directory_install}/java/${base_name}-linux-x64.rpm",
	    user => root,
	    path => '/bin',
	    creates => "${directory_install}/java/${base_name}-linux-x64.rpm",
	}

	exec{ "Install Java JDK":
		command => "/bin/rpm -Uvh ${directory_install}/java/${base_name}-linux-x64.rpm",
	    creates => "/usr/java/${target_name}/jre/bin/java",
		path => '/bin',
		user => root
	}

	# Install Sun/Oracle JDK java, javaws and javac with alternatives –install command
	exec {
		"Alt: java":
			command => "/usr/sbin/alternatives --install /usr/bin/java java /usr/java/${target_name}/jre/bin/java 20000",
			user => root,
			require => Exec["Install Java JDK"];
		"Alt: javaws":
			command => "/usr/sbin/alternatives --install /usr/bin/javaws javaws /usr/java/${target_name}/jre/bin/javaws 20000",
			user => root,
			require => Exec["Alt: java"];
		"Alt: javac":
			command => "/usr/sbin/alternatives --install /usr/bin/javac javac /usr/java/${target_name}/bin/javac 20000",
			user => root,
			require => Exec["Alt: javaws"];
		"Alt: jar":
			command => "/usr/sbin/alternatives --install /usr/bin/jar jar /usr/java/${target_name}/bin/jar 20000",
			user => root,
			require => Exec["Alt: javac"];
	}

	exec { "Set JAVA_HOME":
		command => "/bin/echo export JAVA_HOME=\"/usr/java/${target_name}\" >> ~/.bash_profile",
		user => vagrant,
		require => Exec["Alt: java"],
	}

}

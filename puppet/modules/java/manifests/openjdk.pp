# Setup machine with Oracle Java SE
# @author Abhishek Dev
# @date 10-Dec-2018

class java::openjdk {

	$openJdkVersion = $v_jdk ? {
        '6' => "java-1.6.0",
		'7' => "java-1.7.0",
		'8' => "java-1.8.0",
		'default' => 'NA',
	}

	exec{ "Install OpenJDK":
		command => "/usr/bin/yum install ${openJdkVersion}-openjdk-devel -y",
	    creates => "/usr/lib/jvm/${openJdkVersion}-openjdk.x86_64/bin/java",
		path => '/bin',
		user => root
	}

	exec { "Set OpenJDK JAVA_HOME":
		command => "/bin/echo export JAVA_HOME=\"/usr/lib/jvm/${openJdkVersion}-openjdk.x86_64\" >> ~/.bash_profile",
		user => vagrant,
		require => Exec["Install OpenJDK"],
	}

}

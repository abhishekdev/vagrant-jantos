# Setup machine with Oracle Java SE
# @author Abhishek Dev
# @date 14-May-2014

# Reference: http://www.if-not-true-then-false.com/2010/install-sun-oracle-java-jdk-jre-6-on-fedora-centos-red-hat-rhel/

class java::jdk6 {

	# Download Oracle Java JDK from here (current version is JDK 6 Update 45) and put in [Project Root]/install/java/
	# http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-javase6-419409.html#jdk-6u45-oth-JPR.
	# Note: Select rpm.bin package jdk-6u45-linux-x64-rpm.bin

	# exec { "Download JDK 6":
	# 	# DOES NOT WORK
	#     command => '/usr/bin/wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn/java/jdk/6u45-b06/jdk-6u45-linux-x64-rpm.bin" -O "${install_src_jdk6}"',
	#     creates => $install_src_jdk6
	# }

	$install_src_jdk6 = "${directory_install}/java/jdk-6u45-linux-x64-rpm.bin"

	file { 'JDK6 Installer':
		path => $install_src_jdk6,
	    ensure => 'present',
	    mode   => '0777',
	    owner  => 'vagrant',
	    before => Exec["Install JDK 6"],
	}

	exec{ "Install JDK 6":
		command => "/bin/sh ${install_src_jdk6}",
	    user => root
	}

	# Install Sun/Oracle JDK java, javaws, libjavaplugin.so (for Firefox/Mozilla) and javac with alternatives –install command
	exec {
		"Alt JDK 6: java":
			command => "/usr/sbin/alternatives --install /usr/bin/java java /usr/java/jdk1.6.0_45/jre/bin/java 10000",
			user => root,
			require => Exec["Install JDK 6"];
		"Alt JDK 6: javaws":
			command => "/usr/sbin/alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.6.0_45/jre/bin/javaws 10000",
			user => root,
			require => Exec["Alt JDK 6: java"];
		"Alt JDK 6: javac":
			command => "/usr/sbin/alternatives --install /usr/bin/javac javac /usr/java/jdk1.6.0_45/bin/javac 10000",
			user => root,
			require => Exec["Alt JDK 6: javaws"];
		"Alt JDK 6: jar":
			command => "/usr/sbin/alternatives --install /usr/bin/jar jar /usr/java/jdk1.6.0_45/bin/jar 10000",
			user => root,
			require => Exec["Alt JDK 6: javac"];
	}

	exec { "Set JDK 6 JAVA_HOME":
		command => '/bin/echo export JAVA_HOME="/usr/java/jdk1.6.0_45" >> ~/.bash_profile',
		user => vagrant,
		require => Exec["Alt JDK 6: java"],
	}

}

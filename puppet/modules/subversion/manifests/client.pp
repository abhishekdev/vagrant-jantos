# Setup machine with Subversion Client
# @author Abhishek Dev
# @date 14-May-2014

class subversion::client {
	
	file { "/etc/yum.repos.d/wandisco-svn.repo":
		mode => 0755,
		source  => "/vagrant/puppet/modules/subversion/files/wandisco-svn.repo",
	}

	exec { "Clean yum Cache":
		command => '/usr/bin/yum clean all',
		refreshonly  => true,
		subscribe => File["/etc/yum.repos.d/wandisco-svn.repo"],
	}

	exec { "Install Subversion":
		command => '/usr/bin/yum -y install subversion',
		refreshonly  => true,
		require => Exec["Clean yum Cache"],
		subscribe => File["/etc/yum.repos.d/wandisco-svn.repo"],
	}
}
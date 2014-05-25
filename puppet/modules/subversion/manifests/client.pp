# Setup machine with Subversion Client
# @author Abhishek Dev
# @date 14-May-2014

class subversion::client {
	
	file { "/etc/yum.repos.d/wandisco-svn.repo":
		mode => 0755,
		source  => "/vagrant/puppet/modules/subversion/files/wandisco-svn.repo",
		before => Package["subversion"],
	}

	package{ "subversion":
		ensure => $v_subversion,
	}
}
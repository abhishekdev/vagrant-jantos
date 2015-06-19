# Setup machine with git
# @author Abhishek Dev
# @date 18-Jun-2015

class git::client {

	package{ "git":
		ensure => "latest",
	}

}

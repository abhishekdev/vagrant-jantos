# Setup machine with git
# @author Abhishek Dev
# @date 18-Jun-2015

class timezone {
    package { "tzdata":
        ensure => installed
    }
}

class timezone::custom inherits timezone {
    file { "/etc/localtime":
        require => Package["tzdata"],
        source => "file:///usr/share/zoneinfo/${timezone}",
    }
}

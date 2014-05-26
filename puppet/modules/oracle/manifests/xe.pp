# Install Oracle XE
# @author Abhishek Dev

class oracle::xe {

  # Download Oracle XE 11g from here and put in [Project Root]/install/oracle/
  # http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html
  # Note: Select Linux package oracle-xe-11.2.0-1.0.x86_64.rpm.zip

  $basename = $v_oracle ? { 
    '11gXE' => "oracle-xe-11.2.0-1.0.x86_64.rpm",
    'default' => 'NA',
  }

  $installerSource = "${directory_install}/oracle/${basename}.zip"

  exec { "Unzip Oracle":
    command => "/usr/bin/unzip -q $installerSource -d ${directory_bin}/oracle11gInstaller",
    creates => "${directory_bin}/oracle11gInstaller/Disk1/${$basename}",
  }
  
  exec { "Install Oracle XE 11g":
    command => "/bin/rpm -ivh ${directory_bin}/oracle11gInstaller/Disk1/${basename} > ${directory_bin}/XEsilentinstall.log",
    creates => "/etc/init.d/oracle-xe",
    require => Exec["Unzip Oracle"],
  }

  file{ "${directory_install}/oracle/xe.rsp":
    ensure => "present",
    source => "/vagrant/puppet/modules/oracle/files/xe.rsp",
    replace => "no",
    before => Exec["Configure Oracle XE"],
  }
  
  exec { "Configure Oracle XE":
    command => "/etc/init.d/oracle-xe configure responseFile=${directory_install}/oracle/xe.rsp >> ${directory_bin}/XEsilentinstall.log" ,
    require => Exec["Install Oracle XE 11g"],
  }
  
  exec { "Set ORACLE_ENV":
    command => "/bin/echo . /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh  >> .bashrc" ,
    require => Exec["Configure Oracle XE"],
    user    => "vagrant",
  }
  
  exec { "Add Vagrant as dba":
    command => "/usr/sbin/usermod -g dba vagrant",
    require => Exec["Set ORACLE_ENV"],
  }

}
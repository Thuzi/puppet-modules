class os::package (
  $packages = [],
  $auto_update = "",
){
  
  # install requested packages
  if $packages {
    package { $packages:
      ensure => latest,
    }
  }
  
  # see if we should install unattended upgrades
  if $auto_update and $auto_update != "false" {
  
  	package { "unattended-upgrades":
      ensure => installed,
    }
  
  	file { "/etc/apt/apt.conf.d/10periodic":
	  ensure => file,    
	  owner => "root",
	  group => "root",
	  mode => 0644,
	  source => "puppet:///modules/os/10periodic",
	  require => Package["unattended-upgrades"],
    }
    
  } else {
  
	file {"/etc/apt/apt.conf.d/10periodic":
	  ensure => absent,
	}
	
  }
  
}

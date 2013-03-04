class os::config (
  $hostname = "",
  $packages = [],
  $auto_update = "",
  $daily_logs = "",
  $admin_email = "",
){
 
  # set hostname if provided
  if $hostname {
    
    exec { "set-hostname":
      command => "hostname $hostname",
      path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
      unless => "hostname | grep $hostname",
    }
    
    host { "$hostname":
      ip => "127.0.1.1",
    }
    
  }
  
  # install requested packages
  if $packages {
    package { $packages:
      ensure => latest,
    }
  }
  
  # see if we should install logwatch and send daily emails
  if $daily_logs and $admin_email {
  
  	package { "logwatch":
      ensure => installed,
    }
    
    file { "/etc/cron.daily/logwatch":
	  ensure => file,    
	  owner => "root",
	  group => "root",
	  mode => 0700,
	  content => template("os/logwatch.cron.erb"),
	  require => Package["logwatch"],
    }
    
  } else {

	file {"/etc/cron.daily/logwatch":
	  ensure => absent,
	}
  
  }
  
  # see if we should install unattended upgrades
  if $auto_update {
  
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

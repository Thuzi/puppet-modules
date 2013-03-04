class os::logwatch (
  $daily_logs = "",
  $admin_email = "",
){
  
  # see if we should install logwatch and send daily emails
  if $daily_logs and $daily_logs != "false" and $admin_email {
  
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
  
}

class mongodb::config (
  $port = "27017",
  $bind = "127.0.0.1",
  $username = "",
  $password = "", 
  $replSet = "",
  $members = [],
  $ulimit_nofile = "1024",
) {
  
  # upstart conf file
  file { "/etc/init/mongodb.conf":
    content => template("mongodb/upstart.conf.erb"),
    mode => "0644",
    notify => Service["mongodb"],
  }
  
  # mongodb conf file
  file { "/etc/mongodb.conf":
    content => template("mongodb/mongodb.conf.erb"),
    mode => "0644",
    notify => Service["mongodb"],
  }
  
}
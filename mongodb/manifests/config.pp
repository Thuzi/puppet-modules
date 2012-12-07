class mongodb::config (
  $port = hiera("MONGODB_SERVER_PORT", "27017"),
  $bind_ip = hiera("MONGODB_SERVER_BIND", "0.0.0.0"),
  $username = hiera("MONGODB_SERVER_USERNAME", ""),
  $password = hiera("MONGODB_SERVER_PASSWORD", ""), 
  $replSet = hiera("MONGODB_SERVER_REPLSET", ""),
  $members = hiera("MONGODB_SERVER_MEMBERS", []),
  $ulimit_nofile = hiera("MONGODB_SERVER_ULIMIT", "1024"),
){
  
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
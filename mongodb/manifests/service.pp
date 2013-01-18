class mongodb::service (
  $username = hiera("MONGODB_SERVER_USERNAME", ""),
  $password = hiera("MONGODB_SERVER_PASSWORD", ""), 
  $replSet = hiera("MONGODB_SERVER_REPLSET", ""),
  $members = hiera("MONGODB_SERVER_MEMBERS", []),  
){

  $app_name = "mongodb"
  
  # service definition
  service { "$app_name":
    enable => true,
    ensure => running,
    require => Class[Mongodb::Install],
  }
  
  # mongodb service is slow to start first time, we must wait for it
  exec { "wait for $app_name":
    command => "/usr/bin/mongo",
    tries => 12,
    try_sleep => 10,
    require => Service[$app_name],
  }
  
  if $replSet {
    # replication config
    exec { "rs.initiate":
      logoutput => true,
      #command => 'mongo --eval "printjson(rs.initiate())"',
      command => template("mongodb/rs-initiate.erb"),
      cwd => "/root",
      path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
      user => "root",
      group => "root",
      tries => 12,
      try_sleep => 10,
      unless => 'mongo --eval "printjson(rs.status())" | grep "\"ok\" : 1"',
      require => Service["mongodb"],
    }
  }
  
}

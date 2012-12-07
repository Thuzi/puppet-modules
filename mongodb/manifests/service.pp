class mongodb::service (
  $username = hiera("MONGODB_SERVER_USERNAME", ""),
  $password = hiera("MONGODB_SERVER_PASSWORD", ""), 
  $replSet = hiera("MONGODB_SERVER_REPLSET", ""),  
){

  # service definition
  service { "mongodb":
    enable => true,
    ensure => running,
    require => Class[Mongodb::Install],
  }
  
  if $replSet {
    # replication config
    exec { "rs.initiate":
      command => 'mongo --eval "printjson(rs.initiate())"',
      cwd => "/root",
      path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
      user => "root",
      group => "root",
      unless => 'mongo --eval "printjson(rs.status())" | grep "\"ok\" : 1"',
      require => Service["mongodb"],
    }
  }
  
}

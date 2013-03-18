class memcached::config (
  $port = "6379",
  $bind = "127.0.0.1",
  $daemon_user = "memcache",
  $memory = "256") {
    
  file {"/etc/memcached.conf":
    owner => "root",
    group => "root",
    mode => 0644,
    content => template("memcached/memcached.conf.erb"),
    require => Class[Memcached::Install],
  }

}

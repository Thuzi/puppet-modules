class memcache::config {
  
  require memcache::params
  
  file {"/etc/memcached.conf":
    owner => "root",
    group => "root",
    mode => 0644,
    content => template("memcached/memcached.conf.erb"),
    require => Class[Memcache::Install],
  }

}

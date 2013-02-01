class memcached::service {
  
  service {"memcached":
    ensure    => running,
    hasstatus => true,
    enable    => true,
    require   => Class[Memcached::Config],
    subscribe => File["/etc/memcached.conf"],
  }
    
}

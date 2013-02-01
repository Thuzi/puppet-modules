class opdemand::cache::memcached {

  require opdemand::common

  class {"memcached::params":
    memory => hiera("MEMCACHED_SERVER_MEMORY", "256"), # in megabytes
    port => hiera("MEMCACHED_SERVER_PORT", "11211"),
    bind => hiera("MEMCACHED_SERVER_BIND", "127.0.0.1"),
    daemon_user => hiera("MEMCACHED_SERVER_DAEMONUSER", "memcache"), # for daemon    
  }
  
  include memcached::install
  include memcached::service
  
}
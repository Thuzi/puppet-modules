class opdemand::cache::memcached {

  require opdemand::common

  class {"memcached::params":
    bind => hiera("MEMCACHED_SERVER_BIND", "0.0.0.0"),
    port => hiera("MEMCACHED_SERVER_PORT", "11211"),
    size => hiera("MEMCACHED_SERVER_MEMORY", "256"),  # in megabytes
    username => hiera("MEMCACHED_USERNAME", "memcache"), # for daemon    
  }
  
  include memcached::install
  include memcached::service
  
}
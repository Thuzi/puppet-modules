class opdemand::cache::memcache {

  require opdemand::common

  # initialize dynamic parameters
  class {"memcache::params":
    bind => hiera("CACHE_BIND", "0.0.0.0"),
    port => hiera("CACHE_PORT", "11211"),
    username => hiera("CACHE_USERNAME", "memcache"),
    size => hiera("CACHE_SIZE", "256"),
  }
  
  # include relevant classes
  include memcache::install
  include memcache::config
  include memcache::service
  
}
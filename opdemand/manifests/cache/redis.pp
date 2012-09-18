class opdemand::cache::redis {

  require opdemand::common

  # initialize dynamic parameters
  class {"redis::params":
    bind => hiera("CACHE_BIND", "0.0.0.0"),
    port => hiera("CACHE_PORT", "6379"),
  }
  
  # include relevant classes
  include redis::install
  include redis::config
  include redis::service
  
}
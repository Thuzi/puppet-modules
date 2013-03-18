class opdemand::cache::redis {

  require opdemand::common

  class {"redis::config":
  	port => hiera("REDIS_SERVER_PORT", "6379"),
    bind => hiera("REDIS_SERVER_BIND", "127.0.0.1"),
    password => hiera("REDIS_SERVER_PASSWORD", ""),
  }
  
  include redis::install
  include redis::service
  
}
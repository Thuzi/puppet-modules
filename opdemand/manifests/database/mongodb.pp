class opdemand::database::mongodb {

  require opdemand::common
  
  include mongodb::install
  
  class {"mongodb::config":
    port => hiera("MONGODB_SERVER_PORT", "27017"),
	bind => hiera("MONGODB_SERVER_BIND", "0.0.0.0"),
	username => hiera("MONGODB_SERVER_USERNAME", ""),
	password => hiera("MONGODB_SERVER_PASSWORD", ""), 
	replSet => hiera("MONGODB_SERVER_REPLSET", ""),
	members => hiera("MONGODB_SERVER_MEMBERS", []),
	ulimit_nofile => hiera("MONGODB_SERVER_FDS", "1024"),  	
  }
  
  class {"mongodb::service":
	replSet => hiera("MONGODB_SERVER_REPLSET", ""),
	members => hiera("MONGODB_SERVER_MEMBERS", []),
  }
  
}
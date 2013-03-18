
class opdemand::database::postgresql {
  
  require opdemand::common
  
  class {"postgres::config":
  	port => hiera("POSTGRES_SERVER_PORT", 5432),
    bind => hiera("POSTGRES_SERVER_BIND", "localhost"), # use "*" to bind to all interfaces
    allow_cidr => hiera("POSTGRES_SERVER_ALLOW", "0.0.0.0/0"),
    username => hiera("POSTGRES_SERVER_USERNAME", ""),
    password => hiera("POSTGRES_SERVER_PASSWORD", ""),
    db_name => hiera("POSTGRES_SERVER_DBNAME", ""),
  }

  include postgres::install
  include postgres::service

}

class opdemand::database::couchdb {

  require opdemand::common

  # initialize dynamic parameters
  class {"couchdb::params":
    allow_cidr => hiera("DATABASE_ALLOW_CIDR", "0.0.0.0/0"),
    bind => hiera("DATABASE_BIND", "0.0.0.0"),
    port => hiera("DATABASE_PORT", "5984"),
    username => hiera("DATABASE_USERNAME", ""),
    password => hiera("DATABASE_PASSWORD", ""),
  }
  
  # include relevant classes
  include couchdb::install
  include couchdb::config
  include couchdb::service
  
}
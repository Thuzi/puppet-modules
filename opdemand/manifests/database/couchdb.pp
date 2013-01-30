class opdemand::database::couchdb {

  require opdemand::common
  
  class {"couchdb::config":
    allow_cidr => hiera("COUCHDB_SERVER_ALLOW", "0.0.0.0/0"),
    bind => hiera("COUCHDB_SERVER_BIND", "0.0.0.0"),
    port => hiera("COUCHDB_SERVER_PORT", "5984"),
    username => hiera("COUCHDB_SERVER_USERNAME", ""),
    password => hiera("COUCHDB_SERVER_PASSWORD", ""),
  }
  
  include couchdb::install    
  include couchdb::service
  
}
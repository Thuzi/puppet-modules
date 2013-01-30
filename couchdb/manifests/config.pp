class couchdb::config (
    allow_cidr => hiera("COUCHDB_ALLOW_CIDR", "0.0.0.0/0"),
    bind => hiera("COUCHDB_SERVER_BIND", "0.0.0.0"),
    port => hiera("COUCHDB_SERVER_PORT", "5984"),
    username => hiera("COUCHDB_SERVER_USERNAME", ""),
    password => hiera("COUCHDB_SERVER_PASSWORD", ""),
){

  file {"/etc/couchdb/local.ini":
    content => template("couchdb/local.ini.erb"),
    owner => "couchdb",
    group => "couchdb",
    mode    => 0640,
    require => Class[Couchdb::Install],
  }
  
  file {"/etc/init.d/couchdb":
    content => template("couchdb/couchdb.erb"),
    owner => "couchdb",
    group => "couchdb",
    mode    => 0750,
    require => Class[Couchdb::Install],
  }

}

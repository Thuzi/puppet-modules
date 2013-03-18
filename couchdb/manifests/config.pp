class couchdb::config (
    $allow_cidr = "0.0.0.0/0",
    $bind = "0.0.0.0",
    $port = "5984",
    $username = "",
    $password = "",
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

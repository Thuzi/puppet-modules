class couchdb::config {

  require couchdb::params

  file {"/etc/couchdb/local.ini":
    content => template("couchdb/local.ini.erb"),
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

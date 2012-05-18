class couchdb::service {

  service {"couchdb":
    enable    => true,
    ensure    => running,
    hasstatus => true,
    require   => [Package["couchdb"], File["/etc/couchdb/local.ini"]],
    subscribe => File["/etc/couchdb/local.ini"],
  }

}

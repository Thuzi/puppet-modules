class couchdb::install {

  # Use current CouchDB from launchpad since Ubuntu's is ancient
  apt::ppa {"ppa:longsleep/couchdb":}

  package {"couchdb":
    ensure => latest,
    require => Apt::Ppa["ppa:longsleep/couchdb"],
  }

  # Kill the zombie CouchDB server started by broken .deb packaging.
  exec {"killall-couchdb":
    command => "/usr/bin/killall -q heart beam.smp couchdb",
  }

  # order deps to work around packaging issue
  Package["couchdb"] ->
  Exec["killall-couchdb"]

}

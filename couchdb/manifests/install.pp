class couchdb::install {

  # Use current CouchDB from launchpad since Ubuntu itself dropped the ball
  apt::ppa {"ppa:longsleep/couchdb":}

  package {"couchdb":
    ensure => latest,
    require => Apt::Ppa["ppa:longsleep/couchdb"],
  }

}

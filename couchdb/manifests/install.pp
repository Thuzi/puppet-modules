class couchdb::install {

  $package_name = "couchdb"
  
  # use a more current couchdb version than ubuntu has
  apt::ppa {"ppa:longsleep/couchdb":}

  # NOTE: use exec instead of package so we can set RUNLEVEL=1
  # which prevents the rabbitmq-server daemon from starting
  # on package install, which is currently broken
  exec { "/usr/bin/apt-get -yq install $package_name":
    environment => "RUNLEVEL=1",
    unless => "/usr/bin/dpkg -l $package_name | tail -1 | grep ^ii",
    require => Apt::Ppa["ppa:longsleep/couchdb"],
  }

}

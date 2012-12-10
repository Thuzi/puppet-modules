# Class: mongodb
#
# This class installs MongoDB (stable)
#
# Notes:
#  This class is Ubuntu specific.
#  By Sean Porter Consulting
#
# Actions:
#  - Install MongoDB using a 10gen Ubuntu repository
#  - Manage the MongoDB service
#  - MongoDB can be part of a replica set
#
# Sample Usage:
#  class { mongodb:
#    replSet => "myReplicaSet",
#    ulimit_nofile => 20000,
#  }
#

$repository = "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"
$package_name = "mongodb"

class mongodb::install {
  
  if !defined(Package["python-software-properties"]) {
    package { "python-software-properties":
      ensure => installed,
    }
  }

  exec { "10gen-apt-repo":
    path => "/bin:/usr/bin",
    command => "echo '${repository}' >> /etc/apt/sources.list",
    unless => "cat /etc/apt/sources.list | grep 10gen",
    require => Package["python-software-properties"],
  }

  exec { "10gen-apt-key":
    path => "/bin:/usr/bin",
    command => "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
    unless => "apt-key list | grep 10gen",
    require => Exec["10gen-apt-repo"],
  }

  exec { "update-apt":
    path => "/bin:/usr/bin",
    command => "apt-get update",
    unless => "ls /usr/bin | grep mongo",
    require => Exec["10gen-apt-key"],
  }

  # NOTE: use exec instead of package so we can set RUNLEVEL=1
  # which prevents the package daemon from starting on install
  exec { "/usr/bin/apt-get -yq install $package_name":
    environment => "RUNLEVEL=1",
    unless => "/usr/bin/dpkg -l $package_name | tail -1 | grep ^ii",
    require => Exec["update-apt"],
  }

}

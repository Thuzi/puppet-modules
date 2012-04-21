class python::install {

  require python::params
  
  # install pip
  package {"python-pip":
    ensure => present,
  }
  
  # virtual env
  exec { "virtualenv::init":
    command => "sudo -u $python::params::username virtualenv venv --distribute",
    cwd => $python::params::repository_path,
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    user => "$python::params::username",
    group => "$python::params::group",
    require => Package["python-virtualenv"],
  }

  # pip install
  exec { "pip::install":
    command => "sudo -u $python::params::username pip install",
    cwd => $python::params::repository_path,
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    user => "$python::params::username",
    group => "$python::params::group",
    require => [ Package["python-pip"], Exec[Virtualenv::Init] ],
    subscribe => Vcsrepo[$python::params::repository_path],
  }

}

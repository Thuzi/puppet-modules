class python::install {

  # define package names
  $pip_package = "python-pip"
  $virtualenv_package = "python-virtualenv"
  
  # install base python packages
  $packages = [ $pip_package, $virtualenv_package ]
  package { $packages:
    ensure => present,
  }
  
  # manage virtualenv directory
  $virtualenv_path = "$python::params::repository_path/venv"  
  file { $virtualenv_path:
    ensure => directory,
    owner => $python::params::username,
    group => $python::params::group,
    mode => 750,
  }
  
  # init virtual env
  exec { "virtualenv::init":
    command => "sudo -u $python::params::username virtualenv $virtualenv_path --distribute",
    cwd => $python::params::repository_path,
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    user => "$python::params::username",
    group => "$python::params::group",
    require => Package[$virtualenv_package],
    # only run if venv doesn't exist
    creates => $virtualenv_path,
  }

  # pip install
  exec { "pip::install":
    command => "sudo -u $python::params::username pip install",
    cwd => $python::params::repository_path,
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    user => "$python::params::username",
    group => "$python::params::group",
    require => [ Package[$pip_package], File[$virtualenv_path] ],
    subscribe => Vcsrepo[$python::params::repository_path],
  }

}

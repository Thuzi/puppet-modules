class python::install {

  # define local vars
  $username = "$python::params::username"
  $group = "$python::params::group"
  $repository_path = "$python::params::repository_path"
  $virtualenv_path = "$python::params::repository_path/venv"
  
  # define package names
  $pip_package = "python-pip"
  $virtualenv_package = "python-virtualenv"
  
  # install base python packages
  $packages = [ $pip_package, $virtualenv_package ]
  package { $packages:
    ensure => present,
  }
  
  # manage virtualenv directory
  file { $virtualenv_path:
    ensure => directory,
    owner => $username,
    group => $group,
    mode => 750,
  }
  
  # init virtual env
  exec { "virtualenv::init":
    command => "sudo -u $username virtualenv $virtualenv_path --distribute",
    cwd => $repository_path,
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    user => $username,
    group => $group,
    require => Package[$virtualenv_package],
    # only run if venv doesn't exist
    creates => $virtualenv_path,
  }

  # pip install
  exec { "pip::install":
    command => "/bin/bash -c 'source $virtualenv_path/bin/activate && pip install -r requirements.txt'",
    cwd => $repository_path,
    user => $username,
    group => $group,
    require => [ Package[$pip_package], File[$virtualenv_path] ],
    subscribe => Vcsrepo[$repository_path],
  }

}

class c2::install (
  $username,
  $group,
  $repository_path,  
){

  $virtualenv_path = "$repository_path/venv"
  $packages = [ "gcc", "python-dev", "libzmq-dev", "python-virtualenv", "python-pip", "mercurial" ]
  
  package { $packages:
    ensure => latest,
  }

  # init virtual env
  exec { "virtualenv::init":
    command => "sudo -u $username virtualenv $virtualenv_path --distribute",
    cwd => $repository_path,
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    user => $username,
    group => $group,
    require => Package["python-virtualenv"],
    # only run if venv doesn't exist
    creates => $virtualenv_path,
  }

  # manage virtualenv directory
  file { $virtualenv_path:
    ensure => directory,
    owner => $username,
    group => $group,
    mode => 750,
    require => [ Exec["virtualenv::init"], Vcsrepo[$repository_path] ],
  }

  file { "$repository_path/requirements.txt":
    ensure => file,
    owner => $username,
    group => $group,
    require => Vcsrepo[$repository_path],
  }
  
  file { "$repository_path/Procfile":
    ensure => file,
    owner => $username,
    group => $group,
    require => Vcsrepo[$repository_path],
  }
    
  # pip install
  exec { "pip::install":
    command => "/bin/bash -c 'source $virtualenv_path/bin/activate && pip install -r requirements.txt'",
    cwd => $repository_path,
    user => $username,
    group => $group,
    require => Exec["virtualenv::init"],
    subscribe => File["$repository_path/requirements.txt"],
  }
  
  # create define for upstart template installation
  define upstart_template () {
    file { "/var/cache/opdemand/$name":
      source => "puppet:///modules/c2/$name",
    }
  }
  
  # install upstart templates
  $templates = [ "master.conf.erb", "process_master.conf.erb", "process.conf.erb"]
  upstart_template { $templates: }
  
}
class nodejs::install {

  require nodejs::params
  
  package {"nodejs":
    ensure => latest,
  }

  package {"npm":
    ensure => latest,
  }

  exec { "nodejs::npm::install":
    command => "sudo -u $nodejs::params::username npm install",
    cwd => $nodejs::params::path,
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    user => "$nodejs::params::username",
    group => "$nodejs::params::group",
    require => Package["npm"],
    subscribe => Vcsrepo[$nodejs::params::path],
  }
    
}

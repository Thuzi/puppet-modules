class nodejs::service {

  require nodejs::params
  
  service {"nodejs":
    ensure => running,
    name => "nodejs",
    provider => upstart,
    require => [ Package["nodejs"], Class[Nodejs::Config] ],
  }

}
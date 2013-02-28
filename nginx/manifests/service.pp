class nginx::service {
  
  service { "nginx":
    ensure => running,
    require => [ Class[Nginx::Install], Class[Nginx::Config] ],
  }

}

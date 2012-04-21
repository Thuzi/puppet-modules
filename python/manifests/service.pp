class python::service {

  require python::params

  service {"python":
    ensure => running,
    provider => upstart,
    require => [ Class[Python::Install], Class[Python::Config] ],
  }

}

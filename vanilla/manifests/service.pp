class vanilla::service {

  service { $vanilla::params::app_name:
    ensure => running,
    provider => upstart,
    require => [ Class[Vanilla::Install], Class[Vanilla::Config] ],
  }

}
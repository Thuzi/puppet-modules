class clojure::service {

  # local variables
  $repository_path = $clojure::params::repository_path
  $app_name = $clojure::params::app_name
  
  service { $nodejs::params::app_name:
    ensure => running,
    provider => upstart,
    require => [ Class[Nodejs::Install], Class[Nodejs::Config] ],
    subscribe => Vcsrepo[$repository_path],
  }

}

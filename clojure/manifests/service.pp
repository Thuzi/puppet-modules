class clojure::service {

  # local variables
  $repository_path = $clojure::params::repository_path
  $app_name = $clojure::params::app_name
  $port = $clojure::params::port
  
  service { $app_name:
    ensure => running,
    provider => upstart,
    require => [ Class[Clojure::Install], Class[Clojure::Config], Class[Clojure::Deps] ],
    subscribe => Vcsrepo[$repository_path],
  }

  # java is slow to start, wait for the listener before completing the puppet run
  exec { "wait for $app_name":
    require => Service[$app_name],
    command => "/usr/bin/wget --spider --tries 10 --retry-connrefused --no-check-certificate http://localhost:$port/",
  }
  
}

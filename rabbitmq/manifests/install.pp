class rabbitmq::install {

  file { "/var/run/rabbitmq":
    ensure => directory,
  }
  
  package { "rabbitmq-server":
    ensure => latest,
    require => File["/var/run/rabbitmq"],
  }
  
}
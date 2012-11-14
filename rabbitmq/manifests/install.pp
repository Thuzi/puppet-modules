class rabbitmq::install {
  
  apt::source { "rabbitmq":
    location => "http://www.rabbitmq.com/debian/",
    release => "testing",
    repos => "main",
    key => "http://www.rabbitmq.com/rabbitmq-signing-key-public.asc",
  }
    
  package { "rabbitmq-server":
    ensure => latest,
    require => Apt::Source["rabbitmq"],
  }
  
}
class rabbitmq::install {
  
  apt::source { "rabbitmq":
    location => "http://www.rabbitmq.com/debian/",
    release => "testing",
    repos => "main",
    key => "http://www.rabbitmq.com/rabbitmq-signing-key-public.asc",
  }

  # NOTE: use exec instead of package so we can set RUNLEVEL=1
  # which prevents the rabbitmq-server daemon from starting
  # on package install, which is currently broken
  exec { "/usr/bin/apt-get -yq install rabbitmq-server":
    environment => "RUNLEVEL=1",
    unless => "/usr/bin/dpkg -l rabbitmq-server | tail -1 | grep ^ii",
    require => Apt::Source["rabbitmq"],
  }
  
}
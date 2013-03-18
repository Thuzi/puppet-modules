class rabbitmq::service {
  
  service {"rabbitmq-server":
    ensure    => running,
    hasstatus => true,
    enable    => true,
    require   => Class[Rabbitmq::Config],
    subscribe => File["/etc/rabbitmq/rabbitmq-env.conf"],
  }
    
}

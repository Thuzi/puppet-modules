class rabbitmq::config {
  
  require rabbitmq::params
  
  file {"/etc/rabbitmq/rabbitmq.conf.d/rabbitmq.config":
    owner => "root",
    group => "root",
    mode => 0644,
    content => template("rabbitmq/rabbitmq.config.erb"),
    require => Class[Rabbitmq::Install],
  }

}

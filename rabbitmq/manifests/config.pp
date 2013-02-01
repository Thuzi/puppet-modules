class rabbitmq::config (
  $bind = "",
  $port = "5672",
  $nodename = $fqdn) {
    
  file {"/etc/rabbitmq/rabbitmq-env.conf":
    owner => "root",
    group => "root",
    mode => 0644,
    content => template("rabbitmq/rabbitmq-env.conf.erb"),
    require => Class[Rabbitmq::Install],
  }

}

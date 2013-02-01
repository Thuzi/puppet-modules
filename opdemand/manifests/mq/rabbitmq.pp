class opdemand::mq::rabbitmq {

  require opdemand::common

  class {"rabbitmq::config"  
    bind => hiera("RABBITMQ_SERVER_BIND", ""), # defaults to all interfaces
    port => hiera("RABBITMQ_SERVER_PORT", 5672),
    nodename => hiera("RABBITMQ_SERVER_NODENAME", $hostname),
  }

  include rabbitmq::install
  include rabbitmq::service

}

class opdemand::mq::rabbitmq {

  require opdemand::common

  # initialize dynamic parameters
  class {"rabbitmq::params":
    bind => hiera("rabbitmq/bind", ""), # defaults to all interfaces
    port => hiera("rabbitmq/port", 5672),
    nodename => hiera("rabbitmq/nodename", $hostname),
  }

  # include relevant classes
  include rabbitmq::install
  include rabbitmq::config
  include rabbitmq::service

}

class opdemand::database::mysql {

  # require opdemand common
  require opdemand::common

  # parameterized inputs default to hiera then second arg
  # initialize dynamic parameters
  class {"mysql::params":
    bind => hiera("DATABASE_BIND", "0.0.0.0"),
    port => hiera("DATABASE_PORT", 3306),
    username => hiera("DATABASE_USERNAME", "mysqluser"),
    password => hiera("DATABASE_PASSWORD", "changeme123"),
  }

  # install and configure mysql
  include mysql::install
  include mysql::config
  include mysql::service

  # # output dynamic orchestration values
  # opdemand::output {"DATABASE_HOST":
     # key => "DATABASE_HOST",
     # value => $ec2_public_hostname,
  # }

}
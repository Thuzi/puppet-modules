
class opdemand::database::postgresql {
  
  # require opdemand common
  require opdemand::common
  
  # parameterized inputs default to hiera then second arg
  # initialize dynamic parameters
  class {"postgres::params":
    bind => hiera("DATABASE_LISTEN", "*"),
    port => hiera("DATABASE_PORT", 5432),
    allow_cidr => hiera("DATABASE_ALLOW_CIDR", "0.0.0.0/0"),
    username => hiera("DATABASE_USERNAME", "pguser"),
    password => hiera("DATABASE_PASSWORD", "changeme123"),
  }

  # install and configure postgres
  include postgres::install
  include postgres::config
  include postgres::service

  # # output dynamic orchestration values
  # opdemand::output {"DATABASE_HOST": 
     # key => "DATABASE_HOST",
     # value => $ec2_public_hostname,
  # }
  
}

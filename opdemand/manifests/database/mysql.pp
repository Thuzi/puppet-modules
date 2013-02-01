class opdemand::database::mysql {

  require opdemand::common

  class {"mysql::config":
    bind => hiera("MYSQL_SERVER_BIND", "0.0.0.0"),
    port => hiera("MYSQL_SERVER_PORT", 3306),
    username => hiera("MYSQL_SERVER_USERNAME", "mysqluser"),
    password => hiera("MYSQL_SERVER_PASSWORD", "changeme123"),
    port => hiera("MYSQL_SERVER_DBNAME", 3306),
  }

  include mysql::install
  include mysql::service

}
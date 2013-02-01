class opdemand::database::mysql {

  require opdemand::common

  class {"mysql::config":
    bind => hiera("MYSQL_SERVER_BIND", "127.0.0.1"),
    port => hiera("MYSQL_SERVER_PORT", 3306),
    username => hiera("MYSQL_SERVER_USERNAME", ""),
    password => hiera("MYSQL_SERVER_PASSWORD", ""),
    db_name => hiera("MYSQL_SERVER_DBNAME", ""),
  }

  include mysql::install
  include mysql::service

}
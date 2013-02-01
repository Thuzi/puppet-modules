class mysql::config (
  $port = "3306",
  $bind = "0.0.0.0",
  $username = "mysqluser",
  $password = "changeme123",
  $db_name = "mysqluser",
){
  
  file {"/etc/mysql/my.cnf":
    content => template("mysql/my.cnf.erb"),
    owner => "root",
    group => "root",
    notify => Service["mysql"],
    require => Class["Mysql::Install"],
  }

  # create database user
  mysql::createuser{ $username:
    passwd => $password,
  } ->
  
  # create separate database for this user
  mysql::createdb{ $db_name:
    owner => $db_name,
  }
  
}


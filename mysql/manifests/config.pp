class mysql::config (
  $port = "3306",
  $bind = "127.0.0.1",
  $username = "",
  $password = "",
  $db_name = "",
){
  
  file {"/etc/mysql/my.cnf":
    content => template("mysql/my.cnf.erb"),
    owner => "root",
    group => "root",
    notify => Service["mysql"],
    require => Class["Mysql::Install"],
  }

  # only create a user and database if all 3 variables were provided
  if (! $username) && ( ! $password) && (! $db_name) {
  
	  # create database user
	  mysql::createuser{ $username:
	    passwd => $password,
	  } ->
	  
	  # create separate database for this user
	  mysql::createdb{ $db_name:
	    owner => $username,
	  }
  }
  
}


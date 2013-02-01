class postgres::config  (
  $port = "5432",
  $allow_cidr = "0.0.0.0/0",
  $bind = "localhost", 			# use "*" to bind to all interfaces
  $username = "",
  $password = "",
  $db_name = "") {
  
  file {"/etc/postgresql/9.1/main/postgresql.conf":
    content => template("postgres/postgresql.conf.erb"),
    owner => "root",
    group => "root",
    notify => Service["postgresql"],
    require => Package["postgresql"],
  }

  file { "/etc/postgresql/9.1/main/pg_hba.conf":
    content => template("postgres/pg_hba.conf.erb"),  
    owner  => "root",
    group  => "root",
    notify => Service["postgresql"],
    require => Package["postgresql"],
  }

  # only create a user and database if all 3 variables were provided
  if $username and $password and $db_name {
  
	  # create database user
	  postgres::createuser{ $username:
	    passwd => $password,
	  } ->
	  
	  # create separate database for this user
	  postgres::createdb{ $db_name:
	    owner => $username,
  	  }
   }
  
}


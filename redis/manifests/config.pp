class redis::config (
  $port = "6379",
  $bind = "127.0.0.1",
  $password = "") {
  
  file {"/etc/redis/redis.conf":
    owner => "root",
    group => "root",
    mode => 0644,
    content => template("redis/redis.conf.erb"),
    require => Package["redis-server"],
  }  

}

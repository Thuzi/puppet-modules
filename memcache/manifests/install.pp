class memcached::install {

  package {"memcached":
    ensure => latest,
  }
  
}
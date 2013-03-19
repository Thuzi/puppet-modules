class os::hostname (
  $hostname = "",
){
 
  # set hostname if provided
  if $hostname {
    
    exec { "set-hostname":
      command => "hostname $hostname",
      path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
      unless => "hostname | grep $hostname",
    }
    
    host { "$hostname":
      ip => "127.0.1.1",
    }
    
  }

}

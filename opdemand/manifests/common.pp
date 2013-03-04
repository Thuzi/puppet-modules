class opdemand::common {
  
  # include base modules
  include apt
  include stdlib
      
  # manage orchestration inputs
  class {"opdemand::inputs":} ->
    
  # process ssh data
  class {"opdemand::ssh::dirs":} ->
  class {"opdemand::ssh::authorized_keys":} ->
  class {"opdemand::ssh::known_hosts":} ->
  class {"opdemand::ssh::private_keys":}
  
  # install OS modules
  class {"os::hostname":
    hostname => hiera("OS_HOSTNAME", ""),
  }
  class {"os::package":  
    packages => hiera("OS_PACKAGES", []),
    auto_update => hiera("OS_AUTO_UPDATE", ""),
  }
  class {"os::logwatch":
    daily_logs => hiera("OS_DAILY_LOGS", ""),
    admin_email => hiera("OS_ADMIN_EMAIL", ""),  
  }
  
}

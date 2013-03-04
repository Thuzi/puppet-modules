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
  
  # install OS module
  class {"os::config":
    hostname => hiera("OS_HOSTNAME", "server"),
    packages => hiera("OS_PACKAGES", []),
    auto_update => hiera("OS_AUTO_UPDATE", ""),
    daily_logs => hiera("OS_DAILY_LOGS", ""),
    admin_email => hiera("OS_ADMIN_EMAIL", ""),  
  }
  
}


class opdemand::ssh::private_keys { 

  require opdemand::common
  require opdemand::ssh::dirs
  
  $deploy_key = hiera("DEPLOY_KEY", "")
  $app_repository_key = hiera("APPLICATION_REPOSITORY_KEY", "")
  
  if $deploy_key {
    opdemand::ssh::private::add { "server":
      contents => $deploy_key,
      user => "root",
      home => "/root",
    }
  }
  
  if $app_repository_key {
    # add app private key to root user
    opdemand::ssh::private::add { "root":
      contents => $app_repository_key,
      user => "root",
      home => "/root",
      prefix => "opdemand",
    }
    # add app private key to ubuntu user
    opdemand::ssh::private::add { "ubuntu":
      contents => $app_repository_key,
      user => "ubuntu",
      home => "/home/ubuntu",
      prefix => "opdemand",
    }
  }
  
}

define opdemand::ssh::private::add($contents,
                                   $user,
                                   $home,
                                   $prefix="id") {
  
  if $contents =~ /^-----BEGIN (...) PRIVATE KEY/ {
    
    if $prefix == "opdemand" {
      # use hardcoded key name
      $user_file_path = "$home/.ssh/opdemand-app"
    } else {
      # name key based on type
      case $1 {
        'RSA': { $user_file_path = "$home/.ssh/$prefix_rsa" }
        'DSA': { $user_file_path = "$home/.ssh/$prefix_dsa" }
      }
    }
    
    file { $user_file_path:
      owner   => $user,
      group   => $group,
      mode    => 600,
      content => $contents,
      ensure => present,
    }
    
  } else {
    notice('skipped server/ssh_private_key installation')
  }
    
}

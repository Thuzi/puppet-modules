class c2::config (
  $username,
  $group,
  $repository_path,  
  $homedir,
  $app_name,
  $service_name,
  $env_path,
  $start_port,
  $concurrency,
  # app settings
  $operators,
  $domain_name,
  $server_url,
  $proxy_url,
  # database
  $database_url,
  $database_username,
  $database_password,
  #mq
  $mq_hostname,
  $mq_port,
  $mq_username,
  $mq_password,
  # chargify
  $enable_smtp,
  $smtp_hostname,
  $smtp_username,
  $smtp_password,
  # github
  $github_client_id,
  $github_client_secret,
  # zendesk
  $zendesk_auth_url,
  $zendesk_auth_token,
  # chargify
  $chargify_url,
  $chargify_apikey,  
){
    
  # rebuild upstart conf files
  exec {"rebuild-upstart":
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    cwd => $repository_path,
    command => "foreman export upstart /etc/init -a $service_name -u $username -e $env_path -t /var/cache/opdemand -p $start_port -c $concurrency",
    # rebuild on change of inputs.sh or the vcsrepo
    subscribe => [ File[$env_path], File["$repository_path/Procfile"] ],
    # notify the service on change
    notify => Service["$service_name"],
  }
  
  file {"$homedir/.c2":
    owner => "ubuntu",
    group => "ubuntu",
    ensure => directory,
    mode => 0600,
    require => Vcsrepo[$repository_path],
  }  
    
  file {"$homedir/.c2/server.yaml":
    owner => "ubuntu",
    group => "ubuntu",
    mode => 0600,
    content => template("c2/server.yaml.erb"),
    require => File["$homedir/.c2"],
  }

  # install cron jobs
  
  file {"/etc/cron.hourly/expire-sessions":
    mode => 0700,
    content => template("c2/expire-sessions.erb"),
  }

  file {"/etc/cron.daily/check-subscriptions":
    mode => 0700,
    content => template("c2/check-subscriptions.erb"),
  }

}
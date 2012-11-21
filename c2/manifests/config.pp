class c2::config (
  $username,
  $group,
  $repository_path,  
  $homedir,
  $app_name,
  $env_path,
  # app settings
  $operators,
  $server_port,
  $proxy_port,
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
    command => "foreman export upstart /etc/init -a $app_name -u $username -e $env_path -t /var/cache/opdemand",
    # rebuild on change of inputs.sh or the vcsrepo
    subscribe => [ File[$env_path], File["$repository_path/Procfile"] ],
    # notify the service on change
    notify => Service[$app_name],
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

}
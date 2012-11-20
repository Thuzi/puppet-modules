class c2::config (
  $username = "ubuntu",
  $group = "ubuntu",
  $repository_path = "/home/ubuntu/repo",  
  $app_name = "c2",
  $env_path = "/var/cache/opdemand/inputs.sh",
  $homedir = "/home/ubuntu",
  $c2_operators = [ "operator", "mboersma", "gabrtv", "dgriff1", "system" ],
  $enable_smtp = "true",
  $zendesk_auth_url = "https://desk.opdemand.com/access/remote/?",
  $zendesk_auth_token = "",
  $github_oauth_id = "",
  $github_oauth_secret = "",
  $smtp_password = "",
  $chargify_url = "",
  $chargify_apikey = "",  
){
  
  require c2::install
  
  # rebuild upstart conf files
  exec {"rebuild-upstart":
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    cwd => $repository_path,
    command => "foreman export upstart /etc/init -a $app_name -u $username -e $env_path -t /var/cache/opdemand",
    # rebuild on change of inputs.sh or the vcsrepo
    subscribe => [ File[$env_path], Vcsrepo[$repository_path] ],
    # notify the service on change
    notify => Service[$app_name],
    require => Class[C2::Install],
  }
  
  file {"$homedir/.c2":
    owner => "ubuntu",
    group => "ubuntu",
    ensure => directory,
    mode => 0600,
    require => Class[C2::Install],
  }  
    
  file {"$homedir/.c2/server.yaml":
    owner => "ubuntu",
    group => "ubuntu",
    mode => 0600,
    content => template("c2/server.yaml.erb"),
    require => File["$homedir/.c2"],
  }  

}
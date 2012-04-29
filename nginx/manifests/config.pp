class nginx::config {
  
  # local variables
  $app_name = $nginx::params::app_name
  $num_workers = $nginx::params::num_workers
  $template_name = $nginx::params::template_name
  $public_root = $nginx::params::public_root
  $server_name = $nginx::params::server_name
  $access_port = $nginx::params::access_port
  
  # install sites-enabled (skip sites-available for now)
  file {"/etc/nginx/sites-enabled/$app_name":
    ensure => file,    
    owner => "root",
    group => "root",
    mode => 0644,
    content => template("nginx/$template_name.conf.erb"),
    require => Class[Nginx::Install],
  }

  # ensure default site is removed
  file {"/etc/nginx/sites-enabled/default":
    ensure => absent,
    require => Class[Nginx::Install],
  }  
  
}

class nginx::config {
  
  # local variables
  $app_name = $nginx::params::app_name
  $num_workers = $nginx::params::num_workers
  $template_name = $nginx::params::template_name
  
  # install sites-enabled (skip sites-available for now)
  file {"/etc/nginx/sites-enabled/$app_name":
    ensure => file,    
    owner => "root",
    group => "root",
    mode => 0644,
    content => template("nginx/$template_name.conf.erb"),
    require => Class[Nginx::Install],
  }
  
}

class opdemand::c2 {

  require opdemand::common

  $username = hiera("APPLICATION_USERNAME", "ubuntu")
  $group = hiera("APPLICATION_GROUP", "ubuntu")
  $home = hiera("APPLICATION_HOME", "/home/ubuntu")
  $repository_path = hiera("APPLICATION_REPOSITORY_PATH", "/home/ubuntu/repo")
  $app_name = hiera("APPLICATION_NAME", "python")
      
  class {"c2::install":}
  class {"c2::config":}
  class {"c2::repository":}
  class {"c2::server":} ->
  class {"c2::proxy":} ->
  class {"c2::service":}

}

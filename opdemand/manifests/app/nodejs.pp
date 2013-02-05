class opdemand::app::nodejs {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::app::repository
  
  # initialize dynamic parameters
  class {"nodejs::params":
    username => hiera("APPLICATION_USERNAME", "ubuntu"),
    group => hiera("APPLICATION_GROUP", "ubuntu"),
    home => hiera("APPLICATION_HOME", "/home/ubuntu"),
    repository_path => hiera("APPLICATION_REPOSITORY_PATH", "/home/ubuntu/repo"),
    app_name => hiera("APPLICATION_NAME", "nodejs"),
    concurrency => hiera("APPLICATION_CONCURRENCY", "web=1"),
    port => hiera("APPLICATION_PORT", 5000),
  }

  # include relevant classes
  include nodejs::install
  include nodejs::config
  include nodejs::service
  include nodejs::deps

}

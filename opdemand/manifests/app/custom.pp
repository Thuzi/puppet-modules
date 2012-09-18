class opdemand::app::custom {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::app::repository
  
  # initialize dynamic parameters
  class {"custom::params":
    username => hiera("APPLICATION_USERNAME", "ubuntu"),
    group => hiera("APPLICATION_GROUP", "ubuntu"),
    home => hiera("APPLICATION_HOME", "/home/ubuntu"),
    repository_path => hiera("APPLICATION_REPOSITORY_PATH", "/home/ubuntu/repo"),
    app_name => hiera("APPLICATION_NAME", "custom"),
  }

  # include relevant classes
  include custom::install
  include custom::config
  include custom::service
  include custom::deps

}

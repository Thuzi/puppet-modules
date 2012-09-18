class opdemand::app::ruby {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::app::repository

  # initialize dynamic parameters
  class {"ruby::params":
    username => hiera("APPLICATION_USERNAME", "ubuntu"),
    group => hiera("APPLICATION_GROUP", "ubuntu"),
    home => hiera("APPLICATION_HOME", "/home/ubuntu"),
    repository_path => hiera("APPLICATION_REPOSITORY_PATH", "/home/ubuntu/repo"),
    app_name => hiera("APPLICATION_NAME", "ruby"),
  }

  # include relevant classes
  include ruby::install
  include ruby::config
  include ruby::service
  include ruby::deps

}

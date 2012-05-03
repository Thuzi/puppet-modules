class opdemand::app::vanilla {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::app::repository
  
  # initialize dynamic parameters
  class {"vanilla::params":
    username => hiera("application/username", "ubuntu"),
    group => hiera("application/group", "ubuntu"),
    home => hiera("application/home", "/home/ubuntu"),
    repository_path => hiera("application/repository_path", "/home/ubuntu/repo"),
    app_name => hiera("application/name", "vanilla"),
  }

  # include relevant python classes
  include vanilla::install
  include vanilla::config
  include vanilla::service

}

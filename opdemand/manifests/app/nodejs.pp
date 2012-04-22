class opdemand::app::nodejs {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::app::repository
  
  # install ppa with precompiled node
  class {"apt":} ->
  apt::ppa {"ppa:chris-lea/node.js":} ->
  
  # initialize dynamic parameters
  class {"nodejs::params":
    username => hiera("application/username", "ubuntu"),
    group => hiera("application/group", "ubuntu"),
    home => hiera("application/home", "/home/ubuntu"),
    repository_path => hiera("application/repository_path", "/home/ubuntu/repo"),
    app_name => hiera("application/name", "nodejs"),
  }

  # include relevant python classes
  include nodejs::install
  include nodejs::config
  include nodejs::service

}

class opdemand::web::nodejs {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::repo::app

  # install ppa with precompiled node
  class {"apt":} ->
  apt::ppa {"ppa:chris-lea/node.js":} ->

  # initialize dynamic parameters
  class {"nodejs::params":
    username => hiera("APPLICATION_USERNAME", "ubuntu"),
    home => hiera("APPLICATION_HOME", "/home/ubuntu"),
    main => hiera("APPLICATION_MAIN", "/home/ubuntu/repo/server.js"),
  }

  # include relevant nodejs classes
  include nodejs::install
  include nodejs::config
  include nodejs::service

}

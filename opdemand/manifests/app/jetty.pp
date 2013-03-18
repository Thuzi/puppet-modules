class opdemand::app::jetty {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::app::repository

  # initialize dynamic parameters
  class {"jetty::params":
    username => hiera("APPLICATION_USERNAME", "ubuntu"),
    group => hiera("APPLICATION_GROUP", "ubuntu"),
    home => hiera("APPLICATION_HOME", "/home/ubuntu"),
    repository_path => hiera("APPLICATION_REPOSITORY_PATH", "/home/ubuntu/repo"),
    app_name => hiera("APPLICATION_NAME", "jetty"),
    port => hiera("APPLICATION_PORT", 5000),
    concurrency => hiera("APPLICATION_CONCURRENCY", "web=1"),    
  }

  # include relevant jetty classes
  include jetty::install
  include jetty::config
  include jetty::service
  include jetty::deps

}

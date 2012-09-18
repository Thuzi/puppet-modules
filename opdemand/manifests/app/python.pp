class opdemand::app::python {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::app::repository

  # initialize dynamic parameters
  class {"python::params":
    username => hiera("APPLICATION_USERNAME", "ubuntu"),
    group => hiera("APPLICATION_GROUP", "ubuntu"),
    home => hiera("APPLICATION_HOME", "/home/ubuntu"),
    repository_path => hiera("APPLICATION_REPOSITORY_PATH", "/home/ubuntu/repo"),
    app_name => hiera("APPLICATION_NAME", "python"),
    num_listeners => hiera("APPLICATION_LISTENERS", 1),
    port => hiera("APPLICATION_PORT", 8000),
  }

  # include relevant python classes
  include python::install
  include python::config
  include python::service
  include python::deps

}

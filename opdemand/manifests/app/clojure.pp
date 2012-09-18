class opdemand::app::clojure {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::app::repository
  
  # initialize dynamic parameters
  class {"clojure::params":
    username => hiera("APPLICATION_USERNAME", "ubuntu"),
    group => hiera("APPLICATION_GROUP", "ubuntu"),
    home => hiera("APPLICATION_HOME", "/home/ubuntu"),
    repository_path => hiera("APPLICATION_REPOSITORY_PATH", "/home/ubuntu/repo"),
    app_name => hiera("APPLICATION_NAME", "clojure"),
  }

  # include relevant classes
  include clojure::install
  include clojure::config
  include clojure::service
  include clojure::deps

}

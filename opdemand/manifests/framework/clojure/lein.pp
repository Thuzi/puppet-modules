class opdemand::framework::clojure::lein{

  # require opdemand common and repo
  require opdemand::common
  require opdemand::repo::app

  # initialize dynamic parameters
  class {"clojure::params":
    # admin
    # service
    bind => hiera("APPLICATION_BIND", "0.0.0.0"),
    port => hiera("APPLICATION_PORT", "8080"),
    # daemon/repository
    username => hiera("APPLICATION_USERNAME", "ubuntu"),
    group => hiera("APPLICATION_GROUP", "ubuntu"),
    home => hiera("APPLICATION_HOME", "/home/ubuntu"),
    repository_path => hiera("APPLICATION_REPOSITORY_PATH", "/home/ubuntu/repo"),
  }

  # include relevant classes
  include clojure::install
  include clojure::config
  include clojure::service
}

class opdemand::framework::django::postgresql {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::repo::app
  
  # initialize dynamic parameters
  class {"django::params":
    # admin
    admin_name => hiera("ADMIN_NAME", "Administrator"),
    admin_username => hiera("ADMIN_USERNAME", "admin"),
    admin_password => hiera("ADMIN_PASSWORD", "changeme123"),
    admin_email => hiera("ADMIN_EMAIL", "admin@example.org"),
    # database
    database_type => hiera("DATABASE_TYPE", "postgresql"),
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
  include django::install
  include django::config
  include django::service

}

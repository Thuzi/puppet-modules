class opdemand::framework::rails::postgresql {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::repo::app
  require opdemand::web::nginx
  
  # initialize dynamic parameters
  class {"rails::params":
    # admin
    admin_name => hiera("ADMIN_NAME", "Administrator"),
    admin_username => hiera("ADMIN_USERNAME", "admin"),
    admin_password => hiera("ADMIN_PASSWORD", "changeme123"),
    admin_email => hiera("ADMIN_EMAIL", "admin@example.org"),
    # database
    database_type => hiera("DATABASE_TYPE", "postgresql"),
    database_host => hiera("DATABASE_HOST", "localhost"),
    database_port => hiera("DATABASE_PORT", "5432"),
    database_name => hiera("DATABASE_NAME", "rails"),
    database_username => hiera("DATABASE_USERNAME", "rails"),
    database_password => hiera("DATABASE_PASSWORD", "changeme123."),
    # service
    bind => hiera("APPLICATION_BIND", "0.0.0.0"),
    port => hiera("APPLICATION_PORT", "8080"),
    # daemon/repository
    username => hiera("APPLICATION_USERNAME", "ubuntu"),
    group => hiera("APPLICATION_GROUP", "ubuntu"),
    home => hiera("APPLICATION_HOME", "/home/ubuntu"),
    repository_path => hiera("APPLICATION_REPOSITORY_PATH", "/home/ubuntu/repo"),
    mode => hiera("APPLICATION_MODE", "production"),
  }
  
  # include relevant classes
  include rails::install
  include rails::config
  include rails::service
  include nginx
  include rails::nginx

}

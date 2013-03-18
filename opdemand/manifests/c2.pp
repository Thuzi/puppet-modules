class opdemand::c2 {

  require opdemand::common

  $username = hiera("APPLICATION_USERNAME", "ubuntu")
  $group = hiera("APPLICATION_GROUP", "ubuntu")
  $home = hiera("APPLICATION_HOME", "/home/ubuntu")
  $repository_path = hiera("APPLICATION_REPOSITORY_PATH", "/home/ubuntu/repo")
  $app_name = hiera("APPLICATION_NAME", "c2")
  $service_name = hiera("APPLICATION_SERVICE_NAME", "c2")
  
  class {"c2::install":
    username => $username,
    group => $group,
    repository_path => $repository_path,
  } 
  
  class {"c2::repository":
    repository_provider => hiera("APPLICATION_REPOSITORY_PROVIDER", "git"),
    repository_key => hiera("APPLICATION_REPOSITORY_KEY", ""),
    repository_url => hiera("APPLICATION_REPOSITORY_URL"),
    repository_path => $repository_path,
    repository_revision => hiera("APPLICATION_REPOSITORY_REVISION", "master"),
    repository_owner => $username,
    repository_group => $group,
  }
  
  class {"c2::config":
    username => $username,
    group => $group,
    repository_path => $repository_path,
    homedir => $home,
    app_name => $app_name,
    service_name => $service_name,
    env_path => hiera("OPDEMAND_ENV_PATH", "/var/cache/opdemand/inputs.sh"),
    start_port => hiera("C2_START_PORT", 8000),
    concurrency => hiera("C2_CONCURRENCY", "proxy=1,server=1,monitor=1,worker=1"),
    # database
    database_url => hiera("COUCHDB_URL"),
    database_username => hiera("COUCHDB_USERNAME"),
    database_password => hiera("COUCHDB_PASSWORD"),
    # mq
    mq_hostname => hiera("C2_MQ_HOSTNAME"),
    mq_port => hiera("C2_MQ_PORT"),
    mq_username => hiera("C2_MQ_USERNAME"),
    mq_password => hiera("C2_MQ_PASSWORD"),
    # application
    operators => hiera("C2_OPERATORS"),
    domain_name => hiera("C2_DOMAIN_NAME"),
    proxy_url => hiera("C2_PROXY_URL"),
    server_url => hiera("C2_SERVER_URL"),
    # smtp
    enable_smtp => hiera("C2_ENABLE_SMTP"),
    smtp_hostname => hiera("C2_SMTP_HOSTNAME"),
    smtp_username => hiera("C2_SMTP_USERNAME"),
    smtp_password => hiera("C2_SMTP_PASSWORD"),
    # github
    github_client_id => hiera("C2_GITHUB_CLIENT_ID"),
    github_client_secret => hiera("C2_GITHUB_CLIENT_SECRET"),
    # zendesk
    zendesk_auth_url => hiera("C2_ZENDESK_AUTH_URL"),
    zendesk_auth_token => hiera("C2_ZENDESK_AUTH_TOKEN"),
    # chargify
    chargify_url => hiera("C2_CHARGIFY_URL"),
    chargify_apikey => hiera("C2_CHARGIFY_APIKEY"),
  }

  # install these modules in order
  class {"c2::monitor": 
    username => $username,
    group => $group,
    repository_path => $repository_path,
  } ->
  
  class {"c2::server":
    username => $username,
    group => $group,
    repository_path => $repository_path,
  } ->
  
  class {"c2::proxy":
    username => $username,
    group => $group,
    repository_path => $repository_path,    
  } ->
  
  class {"c2::service":
    repository_path => $repository_path,
    service_name => $service_name,
  }

}

class opdemand::web::nginx {
  
  require opdemand::common

  # initialize dynamic parameters
  class {"nginx::params":
    # nginx params
    template_name => hiera("NGINX_TEMPLATE_NAME", "default"),
    public_root => hiera("NGINX_PUBLIC_ROOT", "/home/ubuntu/repo/public"),
    # application params
    app_name => hiera("APPLICATION_NAME", "nginx"),
    start_port => hiera("APPLICATION_PORT", "5000"),
    num_listeners => hiera("APPLICATION_LISTENERS", 1),
  }

  # include relevant classes
  include nginx::install
  include nginx::config
  include nginx::service

}
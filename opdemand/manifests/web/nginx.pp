class opdemand::web::nginx {
  
  require opdemand::common

  class {"nginx::config":
    template_name => hiera("NGINX_TEMPLATE_NAME", "default"),
    public_root => hiera("NGINX_PUBLIC_ROOT", "/home/ubuntu/repo/public"),
    nginx_port => hiera("NGINX_PORT", 80),
    server_name => hiera("NGINX_SERVER_NAME", $ec2_public_hostname),
    app_name => hiera("NGINX_APP_NAME", "app"),
    app_port => hiera("NGINX_APP_PORT", "5000"),
    app_listeners => hiera("NGINX_APP_LISTENERS", 1),
  }

  include nginx::install
  include nginx::service

}
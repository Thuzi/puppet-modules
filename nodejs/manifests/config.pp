class nodejs::config {

  require nodejs::params

  $env_inputs = "/var/cache/opdemand/inputs.sh"
  
  exec {"nodejs::foreman::upstart":
    path => $path,
    cwd => "$nodejs::params::path",
    command => "sudo foreman export upstart /etc/init -a nodejs -u ubuntu -e $env_inputs",
    # re-exec on inputs.sh change
    subscribe => File[$env_inputs],
    # notify the nodejs service on change
    notify => Service["nodejs"],
  }
  
}
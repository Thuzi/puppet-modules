class python::config {

  exec {"upstart":
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    cwd => "$python::params::repository_path",
    command => "sudo foreman export upstart /etc/init -a $python::params::app_name -u $python::params::username -e $env_inputs",
    # re-exec on inputs.sh change
    subscribe => File[$opdemand::inputs::env_path],
    # notify the service on change
    notify => Service[$python::params::app_name],
  }

}
class python::config {

  require python::params

  exec {"upstart":
    path => $path,
    cwd => "$python::params::repository_path",
    command => "sudo foreman export upstart /etc/init -a python -u ubuntu -e $env_inputs",
    # re-exec on inputs.sh change
    subscribe => File[$env_path],
    # notify the service on change
    notify => Service["python"],
  }

}
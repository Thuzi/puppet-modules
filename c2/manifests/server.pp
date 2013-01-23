class c2::server (
  $username,
  $group,
  $repository_path,
) {
  
  require c2::install
           
  # re-usable function to install a python project into virtualenv
  define python::install ($username, $group, $repository_path){
    
    exec { "python::install::$name":
      command => ". venv/bin/activate && cd $name && python setup.py install",
      provider => "shell",
      logoutput => false,   # log raw output from shell command
      cwd => "$repository_path",
      path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
      user => "$username",
      group => "$group",
      subscribe => Vcsrepo["$repository_path"],
    }
  }
         
  $c2_projects = [ 'c2-core', 'c2-server', 'c2-client',
                   'c2-provider-aws', 'c2-provider-mock', 'c2-provider-heroku',
                   'cyclone', 'opdemand-cli' ]
  
  # `python setup.py install` for all c2 projects into virtualenv
  python::install { $c2_projects:
    username => $username,
    group => $group,
    repository_path => $repository_path, 
  }

  exec { "c2-init":
    command => ". venv/bin/activate && cd c2-server && $repository_path/c2-server/bin/c2-init",
    provider => "shell",    
    logoutput => false,   # log raw output from shell command
    cwd => "$repository_path",
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin" ],
    user => $username,
    group => $group,
    require => Python::Install[$c2_projects],
    subscribe => Vcsrepo[$repository_path],
  }
  
  exec { "c2-update-views":
    command => ". venv/bin/activate && cd c2-server && $repository_path/c2-server/bin/c2-update-views",
    provider => "shell",    
    logoutput => false,   # log raw output from shell command
    cwd => "$repository_path",
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin" ],
    user => $username,
    group => $group,
    require => Exec["c2-init"],
    subscribe => Vcsrepo[$repository_path],
  }
  
}
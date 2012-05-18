class python::deploy {

  # local variables
  $repository_path = $python::params::repository_path
  $username = $python::params::username
  $group = $python::params::group
  
  # exec bin/deploy if the repo changed
  exec { "bin::deploy":
    command => "$repository_path/bin/deploy",
    # log raw output from shell command
    logoutput => true,
    cwd => $repository_path,
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    user => $username,
    group => $group,
    require => [Class[Python::Install], Class[Python::Config] ],
    subscribe => Vcsrepo[$repository_path],
    # only if the script exists and is executable
    onlyif => "test -x $repository_path/bin/deploy",
  }

}
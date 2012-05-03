class vanilla::install {

  # local variables
  $repository_path = $vanilla::params::repository_path
  $username = $vanilla::params::username
  $group = $vanilla::params::group
  
  # exec bin/deploy if the repo changed
  exec { "bin::deploy":
    command => "$repository_path/bin/deploy",
    # log raw output from shell command
    logoutput => true,
    cwd => $repository_path,
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    user => $username,
    group => $group,
    require => Vcsrepo[$repository_path],
    subscribe => Vcsrepo[$repository_path],
  }
  
  # create define for upstart template installation
  define upstart_template () {
    file { "/var/cache/opdemand/$name":
      source => "puppet:///modules/vanilla/$name",
    }
  }
  
  # install upstart templates
  $templates = [ "master.conf.erb", "process_master.conf.erb", "process.conf.erb"]
  upstart_template { $templates: }
  
}

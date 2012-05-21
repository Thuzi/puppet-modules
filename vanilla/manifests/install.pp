class vanilla::install {

  # local variables
  $repository_path = $vanilla::params::repository_path
  $username = $vanilla::params::username
  $group = $vanilla::params::group
  
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

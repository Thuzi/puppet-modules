class jetty::install {

  # define local vars
  $username = "$jetty::params::username"
  $group = "$jetty::params::group"
  $repository_path = "$jetty::params::repository_path"
  $upstart_template_path = "/var/cache/opdemand/upstart/$jetty::params::app_name"
  
  $packages = [ "maven2" ]
  package { $packages:
    ensure => present,
  }

  # create define for upstart template installation
  define upstart_template () {
    file { "/var/cache/opdemand/$name":
      source => "puppet:///modules/jetty/$name",
    }
  }

  # install upstart templates
  $templates = [ "master.conf.erb", "process_master.conf.erb", "process.conf.erb"]
  upstart_template { $templates: }
  
}

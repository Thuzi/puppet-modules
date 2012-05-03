class clojure::install {

  # define local vars
  $username = "$clojure::params::username"
  $group = "$clojure::params::group"
  $repository_path = "$clojure::params::repository_path"
  $app_name = "$clojure::params::app_name"
  $upstart_template_path = "/var/cache/opdemand/upstart/$app_name"  
  $packages = [ "leiningen" ]
  
  package { $packages:
        ensure => latest,
  }

  exec { "lein::deps":
    command => "lein deps",
    cwd => $repository_path,
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    user => $username,
    group => $group,
    subscribe => Vcsrepo["$repository_path"],
  }

  # create define for upstart template installation
  define upstart_template () {
    file { "/var/cache/opdemand/$name":
      source => "puppet:///modules/clojure/$name",
    }
  }
  
  # install upstart templates
  $templates = [ "master.conf.erb", "process_master.conf.erb", "process.conf.erb"]
  upstart_template { $templates: }
  
}

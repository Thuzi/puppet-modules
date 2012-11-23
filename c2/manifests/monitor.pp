class c2::monitor (
  $username,
  $group,
  $repository_path,
) {
    
  $ppa = "ppa:scottritchie/erlang-backports"
  $packages = [ "erlang-base" ]
  
  # install ppa with erlang R15
  apt::ppa {$ppa:}
    
  package { $packages:
    ensure => present,
    require => Apt::Ppa[$ppa],
  }
  
  exec { "rebar::compile":
    command => "$repository_path/c2-monitor/bin/rebar get-deps compile",
    logoutput => false,   # log raw output from shell command
    cwd => "$repository_path/c2-monitor",
    path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
    user => "$username",
    group => "$group",
    subscribe => Vcsrepo["$repository_path"],
    onlyif => "test -x $repository_path/c2-monitor/bin/rebar",
  }
  
}
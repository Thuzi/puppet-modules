class c2::monitor (
) {
    
  $ppa = "ppa:scottritchie/erlang-backports"
  $packages = [ "erlang-base" ]
  
  # install ppa with erlang R15
  apt::ppa {$ppa:}
    
  package { $packages:
    ensure => present,
    require => Apt::Ppa[$ppa],
  }
  
}
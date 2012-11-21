class c2::service ($repository_path){
    
  service {"c2":
    ensure    => running,
    hasstatus => true,
    enable    => true,
    require   => [ Class[C2::Server], Class[C2::Proxy] ],
    subscribe => Vcsrepo[$repository_path],
  }
    
}

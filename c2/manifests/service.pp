class c2::service (
  $repository_path,
  $service_name){
  
  service {"$service_name":
    ensure    => running,
    hasstatus => true,
    enable    => true,
    require   => [ Class[C2::Server], Class[C2::Proxy] ],
    subscribe => Vcsrepo[$repository_path],
  }
    
}

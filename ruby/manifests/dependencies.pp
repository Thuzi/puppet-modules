class ruby::dependencies {

  # local variables
  $repository_path = "$ruby::params::repository_path"
  $username = "$ruby::params::username"
  $group = "$ruby::params::group"
  
  # bundle install latest dependencies
  exec { "bundle-install":
    command => "bundle install --deployment",
    path => ["/sbin", "/bin", "/usr/bin", "/usr/sbin", "/usr/local/bin"],
    cwd => $repository_path,
    user => $username,
    group => $group,
    require => [ Class[Ruby::Install], Class[Ruby::Config] ],
    subscribe => Vcsrepo[$repository_path],
  }

}
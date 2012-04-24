class ruby::dependencies {

  # local variables
  $repository_path = "$ruby::params::repository_path"
  $username = "$ruby::params::username"
  $group = "$ruby::params::group"
  
  # bundle install latest dependencies
  exec { "bundle-install":
    command => "bundle install --deployment",
    cwd => $repository_path,
    user => $username,
    group => $group,
    require => [ Class[Ruby::Install], Class[Ruby::Config] ],
    subscribe => Vcsrepo[$repository_path],
  }

}
class c2::repository (
  $repository_provider,
  $repository_key,
  $repository_url,
  $repository_path,
  $repository_revision,
  $repository_owner,
  $repository_group){

  # require common including ssh classes
  require opdemand::common
  
  # determine ssh identity file to use
  if $repository_key {
    $identity_path = "/home/ubuntu/.ssh/opdemand-app"
  } else {
    $identity_path = "/dev/null"
  }
  
  # manage a version control repository
  vcsrepo { $repository_path:
    ensure => latest,
    provider => $repository_provider,
    source => $repository_url,
    # NOTE: as of 2012/4/12 this only works on initial clone
    revision => $repository_revision,
    owner => $repository_owner,
    group => $repository_group,
    require => [ Class["Opdemand::Ssh::Known_hosts"], Class["Opdemand::Ssh::Private_keys"] ],
    identity => $identity_path,
  }

  # manage the repository directories
  file { $repository_path:
    ensure => directory,
    owner => $repository_owner,
    group => $repository_group,
    mode => 0750,
    require => Vcsrepo[$repository_path],
  }
  
}

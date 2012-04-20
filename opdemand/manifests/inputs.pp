class opdemand::inputs {

  file {"/var/cache/opdemand/inputs.json":
    ensure => present
  }

  file {"/var/cache/opdemand/inputs.sh":
    ensure => present
  }
  
}
class opdemand::inputs {

  $exec_path = "/var/cache/opdemand"
  $json_path = "$exec_path/inputs.json"
  $env_path = "$exec_path/inputs.sh"
  
  file {$json_path:
    ensure => present
  }

  file {$env_path:
    ensure => present
  }
  
}
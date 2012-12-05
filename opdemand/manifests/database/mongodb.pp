class opdemand::database::mongodb {

  require opdemand::common
  
  # include relevant classes
  include mongodb::install
  include mongodb::config
  include mongodb::service
  
}
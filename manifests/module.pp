# Type: rsyslog::module
# ===========================
#
# Create a .conf file for the given module.
# 

define rsyslog::module (
    $priority = 10,
    $parameters = {},
  ) {

  validate_numeric($priority)
  validate_hash($parameters)

  file{"rsyslog_module_${name}":
    owner   => 'root',
    group   => 'root',
    path    => "${::rsyslog::config_dir_path}/00${priority}_${name}.conf",
    content => template('rsyslog/module.conf.erb'),
  } ~> Service[$::rsyslog::service_name]

}

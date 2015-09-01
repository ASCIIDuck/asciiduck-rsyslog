# Type: rsyslog::template
# ===========================
#
# Create a .conf file for given template.
# 

define rsyslog::template (
    $format,
    $priority = 10,
  ) {

  if $::rsyslog::manage_rsyslog {
    file{"rsyslog_template_${name}":
      owner   => 'root',
      group   => 'root',
      path    => "${::rsyslog::config_dir_path}/05${priority}_${name}.conf",
      content => template('rsyslog/template.conf.erb'),
    } ~> Service[$::rsyslog::service_name]
  }
}

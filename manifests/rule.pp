# Type: rsyslog::rule
# ===========================
#
# Create a .conf file for given rule(s).
# 

define rsyslog::rule (
    $pattern  = '',
    $file     = '',
    $host     = '',
    $proto    = '',
    $port     = '',
    $discard  = false,
    $format   = '',
    $rules    = [],
    $priority = 10,
  ) {
  if !empty($rules) {
    validate_array($rules)
    $final_rules = $rules
  }
  else {
    validate_string($pattern)
    validate_bool($discard)
    if !empty($file) {
      validate_absolute_path($file)
    }
    if !empty($format) {
      validate_string($format)
    }

    if (!empty($host) and empty($proto)) or (empty($host) and !empty($proto)) {
      fail('To forward messages you must specify the host and the protocol')
    }
    if !empty($host) {
      validate_string($host)
    }
    if !empty($port) {
      validate_numeric($port)
    }
    if !empty($proto) {
      validate_re($proto,'(udp|tcp|tcpo)')
    }
    $final_rules = [ {
      'pattern' => $pattern,
      'file'    => $file,
      'host'    => $host,
      'proto'   => $proto,
      'port'    => $port,
      'discard' => $discard,
      'format'  => $format,
    } ]
  }

  if $::rsyslog::manage_rsyslog {
    file{"rsyslog_rule_${name}":
      owner   => 'root',
      group   => 'root',
      path    => "${::rsyslog::config_dir_path}/10${priority}_${name}.conf",
      content => template('rsyslog/rule.conf.erb'),
    } ~> Service[$::rsyslog::service_name]
  }
}

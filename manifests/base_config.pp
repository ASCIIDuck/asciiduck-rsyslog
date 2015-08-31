# == Class rsyslog::base_config
#
# This class is called from rsyslog for service config.
#
class rsyslog::base_config {
  file{$::rsyslog::config_file_path:
    owner   => 'root',
    group   => 'root',
    content => template($::rsyslog::config_template),
  }
  file{$::rsyslog::config_dir_path:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    recurse => true,
    purge   => $::rsyslog::purge_config,
  }
}

# == Class rsyslog::install
#
# This class is called from rsyslog for install.
#
class rsyslog::install {

  package { $::rsyslog::package_name:
    ensure => present,
  }
}

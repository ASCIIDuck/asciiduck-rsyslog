# == Class rsyslog::service
#
# This class is meant to be called from rsyslog.
# It ensure the service is running.
#
class rsyslog::service {

  service { $::rsyslog::service_name:
    ensure => $::rsyslog::service_start,
    enable => $::rsyslog::service_enable,
  }
}

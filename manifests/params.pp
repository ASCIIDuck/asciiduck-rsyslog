# == Class rsyslog::params
#
# This class is meant to be called from rsyslog.
# It sets variables according to platform.
#
class rsyslog::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'rsyslog'
      $service_name = 'rsyslog'
      $work_dir = '/var/spool/rsyslog'
      $user             = 'syslog'
      $group            = 'syslog'
      $file_owner       = 'syslog'
      $file_group       = 'adm'
      $dir_owner        = 'syslog'
      $dir_group        = 'adm'
    }
    'RedHat', 'Amazon': {
      case $::operatingsystemmajrelease {
        '5': {
          $package_name = 'rsyslog5'
        }
        default: {
          $package_name = 'rsyslog'
        }
      }
      $service_name = 'rsyslog'
      $work_dir = '/var/lib/rsyslog'
      $user             = 'root'
      $group            = 'root'
      $file_owner       = 'root'
      $file_group       = 'root'
      $dir_owner        = 'root'
      $dir_group        = 'root'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

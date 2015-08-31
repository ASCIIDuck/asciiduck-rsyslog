# Class: rsyslog
# ===========================
#
# Full description of class rsyslog here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class rsyslog (
  $package_name     = $::rsyslog::params::package_name,
  $service_name     = $::rsyslog::params::service_name,
  $service_start    = true,
  $service_enable   = true,
  $max_message_size = '2k',
  $work_dir         = $::rsyslog::params::work_dir,
  $umask            = '0000',
  $user             = $::rsyslog::params::user,
  $group            = $::rsyslog::params::group,
  $file_owner       = $::rsyslog::params::file_owner,
  $file_group       = $::rsyslog::params::file_group,
  $file_mode        = '0600',
  $dir_owner        = $::rsyslog::params::dir_owner,
  $dir_group        = $::rsyslog::params::dir_group,
  $dir_mode         = '0750',
  $purge_config     = true,
  $config_file_path = '/etc/rsyslog.conf',
  $config_dir_path  = '/etc/rsyslog.d/',
  $config_template  = 'rsyslog/rsyslog.conf.erb',
  $manage_rsyslog   = true,
) inherits ::rsyslog::params {

  validate_string($package_name)
  validate_string($service_name)
  validate_bool($service_start)
  validate_bool($service_enable)
  validate_string($max_message_size)
  validate_re($umask,'^[0-7]{3,4}$')
  validate_string($user)
  validate_string($group)
  validate_string($file_owner)
  validate_string($file_group)
  validate_re($file_mode,'^[0-7]{3,4}$')
  validate_string($dir_owner)
  validate_string($dir_group)
  validate_re($dir_mode,'^[0-7]{3,4}$')
  validate_bool($purge_config)
  validate_absolute_path($config_file_path)
  validate_absolute_path($config_dir_path)
  validate_string($config_template)


  if $manage_rsyslog {
    class { '::rsyslog::install': } ->
    class { '::rsyslog::base_config': } ~>
    class { '::rsyslog::service': } ->
    Class['::rsyslog']
  }
}

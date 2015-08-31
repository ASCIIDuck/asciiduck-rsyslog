# == Class rsyslog::default_config
#
# This class is *NOT* called from rsyslog.
# Include it if you want the default rsyslog rules
# for your OS.
#

class rsyslog::default_config {
  case $::osfamily {
    'Debian': {
      rsyslog::rule {'defaults':
        priority => 50,
        rules    => [
          {
            pattern => 'authpriv.*',
            file    => '/var/log/auth.log'
          },
          {
            pattern => '*.*;auth,authpriv.none',
            file    => '-/var/log/syslog'
          },
          {
            pattern => 'kern.*',
            file    => '-/var/log/kern.log'
          },
          {
            pattern => 'mail.*',
            file    => '-/var/log/mail.log'
          },
          {
            pattern => 'mail.err',
            file    => '-/var/log/mail.err'
          },
          {
            pattern => 'news.err',
            file    => '/var/log/news.err'
          },
          {
            pattern => 'news.crit',
            file    => '/var/log/news.crit'
          },
          {
            pattern => 'news.notice',
            file    => '-/var/log/news.notice'
          },
          {
            pattern => '*.emerg',
            file    => ':omusrmsg:*'
          },
        ],
      }
    }
    'RedHat', 'Amazon': {
      rsyslog::rule {'defaults':
        priority => 50,
        rules    => [
          {
            pattern => '*.info;mail.none;authpriv.none;cron.none',
            file    => '/var/log/messages'
          },
          {
            pattern => 'authpriv.*',
            file    => '/var/log/secure'
          },
          {
            pattern => 'mail.*',
            file    => '-/var/log/maillog'
          },
          {
            pattern => 'cron.*',
            file    => '/var/log/cron'
          },
          {
            pattern => '*.emerg',
            file    => ':omusrmsg:*'
          },
          {
            pattern => 'uucp,news.crit',
            file    => '/var/log/spooler'
          },
          {
            pattern => 'local7.*',
            file    => '/var/log/boot.log'
          },
        ],
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

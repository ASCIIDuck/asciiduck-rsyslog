#### Table of Contents

1. [Overview](#overview)
3. [Setup - The basics of getting started with rsyslog](#setup)
    * [What rsyslog affects](#what-rsyslog-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with rsyslog](#beginning-with-rsyslog)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This module presents a more flexible, if not yet feature parity, alternative to other rsyslog modules on the forge currently. The biggest gain is the defined types which allow more flexibility in adding logging rules.


## Setup

### What rsyslog affects

* /etc/rsyslog.conf
* /etc/rsyslog.d/
* rsyslog run directory

### Setup Requirements

No current special requirements, other than puppetlabs/stdlib

### Beginning with rsyslog

The main class will create a very basic configuration with no rules.

~~~puppet
include 'rsyslog'
~~~

To make use of the default rules for your OS you should also use include rsyslog::default\_configuration

~~~puppet
include 'rsyslog'
include 'rsyslog::default\_configuration'
~~~


## Usage

To add new rule to log to a file

~~~puppet
rsyslog::rule{'user7':
  pattern => 'user7.\*',
  file    => '/var/log/user7.log',
}
~~~

To add new rule to log to a remote host, you must provide at least the host and the protocol. The protocol may be one of three options, 'udp', 'tcp', or 'tcpo' (TCP with octet framing).

~~~puppet
rsyslog::rule{'user7':
  pattern => 'user7.\*',
  host    => 'logger.example.com',
  proto   => 'udp'
}
~~~

## Reference

## Limitations

Currently no overt support for more complicated configurations, like TLS.

## Development

Do the usual fork/commit/pull request shuffle. Be sure to keep tests up to date.


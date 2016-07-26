class activemq::config (
  $prr = undef,
  $vco = undef,
  $slr = undef,
  $producerFlowControl = $activemq::params::producerFlowControl,
) {

  if $activemq::cluster_enabled {
    $real_data = $activemq::real_mount['dir']

    autofs::include { "/- ${activemq::real_mount['mapfile']} --timeout=300 --ghost": }

    autofs::directmount { $activemq::real_mount['dir']:
      options  => $activemq::real_mount['options'],
      location => $activemq::real_mount['location'],
      mapfile  => $activemq::real_mount['mapfile'],
    }
  }
  else {
    $real_data = $activemq::data
  }

  file { '/var/run/activemq':
    ensure => directory,
    owner  => $activemq::user,
    group  => $activemq::user,
    mode   => '0755',
  }

  file { '/etc/default/activemq':
    ensure  => present,
    owner   => $activemq::user,
    mode    => '0664',
    content => template('activemq/default.erb')
  }

  file { "${activemq::home}/bin/activemq":
    ensure => present,
    owner  => $activemq::user,
    group  => $activemq::user,
    mode   => '0775',
    source => 'puppet:///modules/activemq/activemq',
  }

  file { "${activemq::confdir}/deduping.xml":
    ensure   => present,
    owner    => $activemq::user,
    group    => $activemq::user,
    content  => template('activemq/deduping.xml.erb'),
  }

  file { "${activemq::confdir}/priority-routing-context.xml":
    ensure   => present,
    owner    => $activemq::user,
    group    => $activemq::user,
    source => 'puppet:///modules/activemq/priority-routing-context.xml',
  }

  file { "${activemq::confdir}/priority-routing-context.properties":
    ensure   => present,
    owner    => $activemq::user,
    group    => $activemq::user,
    source => 'puppet:///modules/activemq/priority-routing-context.properties',
  }

  file { "${activemq::confdir}/${activemq::configfile}":
    ensure  => present,
    owner   => $activemq::user,
    group   => $activemq::user,
    content => template('activemq/activemq.xml.erb')
  }

  if $::operatingsystemmajrelease == 6 {

    file { '/etc/init.d/activemq':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => template('activemq/init.erb')
    }
  }
  elsif  $::operatingsystemmajrelease == 7 {

    file { '/usr/lib/systemd/system/activemq.service':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('activemq/activemq.service.erb')
    }

  }


}

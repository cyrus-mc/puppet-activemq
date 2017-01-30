class activemq::params {

  # non-OS specific default parameters
  $package_ensure = hiera('activemq::package_ensure', 'present')
  $service_ensure = hiera('activemq::service_ensure', 'running')
  $service_enable = hiera('activemq::service_enable', true)

  $file_owner = hiera('activemq::file_owner', 'root')
  $file_group = hiera('activemq::file_group', 'root')
  $file_mode  = hiera('activemq::file_mode', '0644')

  # default configuration
  $activemq_opts_memory = hiera('activemq::activemq_opts_memory', '-Xms512m -Xmx512m')
  $activemq_home        = hiera('activemq::activemq_home', '/etc/activemq')
  $activemq_data        = hiera('activemq::activemq_data', '/var/lib/activemq/data')

  $template             = hiera('activemq::source', "${module_name}/activemq.xml")

  $default_transportConnectors = {
    openwire => {
      protocol          => 'tcp',
      network_interface => '0.0.0.0',
      port              => 61616,
      parameters        => 'maximumConnections=1000&amp;wireFormat.maxFrameSize=209715200'
    },
    amqp => {
      protocol          => 'amqp',
      network_interface => '0.0.0.0',
      port              => '5672',
      parameters        => 'maximumConnections=1000&amp;wireFormat.maxFrameSize=104857600'
    },
    stomp => {
      protocol          => 'stomp',
      network_interface => '0.0.0.0',
      port              => '61613',
      parameters        => 'maximumConnections=1000&amp;wireFormat.maxFrameSize=104857600'
    },
    mqtt => {
      protocol          => 'mqtt',
      network_interface => '0.0.0.0',
      port              => '1883',
      parameters        => 'maximumConnections=1000&amp;wireFormat.maxFrameSize=104857600'
    }
  }

  $default_networkConnectors = {}

  $transportConnectors = hiera('activemq::transportConnectors', $default_transportConnectors)
  $networkConnectors   = hiera('activemq::networkConnectors', $default_networkConnectors)

  # OS specific default parameters
  case $::osfamily {
    'RedHat': {
      $service_name       = hiera('activemq::service_name', 'activemq')
      $service_hasrestart = hiera('activemq::service_hasrestart', true)

      $package            = hiera('activemq::package', 'activemq')

      $config_path        = hiera('activemq::config_path', "${activemq_home}/conf")
    }
    
    default: {
      fail("${module_name} : unsupported OS family ${::osfamily}")
    }
  }
}

class activemq::params {

  $home         = '/opt/smarsh/activemq'
  $base         = $home
  $confdir      = "${home}/conf"
  $configfile   = 'activemq.xml'
  $user         = 'activemq'
  $data         = "${home}/data"
  $tmp          = "${home}/tmp"
  $memory       = '-Xms1G -Xmx3G'
  $version      = hiera('activemq::version')

  $default_mount = {
    'dir'      => hiera('activemq::cluster_dir'),
    'options'  => '-fstype=nfs4,rw,nosuid,nodev,soft,noatime',
    'location' => hiera('activemq::cluster_mount_location'),
    'mapfile'  => '/etc/auto.mounts',
  }
  
  $default_networkConnectors = {}
  $default_transportConnectors = {
    'openwire' => {
      'protocol'          => 'tcp',
      'network_interface' => '0.0.0.0',
      'port'              => 61616,
      'parameters'        => 'maximumConnections=1000&amp;wireFormat.maxFrameSize=209715200'
    }
  }
}

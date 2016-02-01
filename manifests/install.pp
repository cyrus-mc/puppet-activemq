class activemq::install {

  group { 'activemq':
  	ensure    => present,
  	allowdupe => false,
  	gid       => 92,
  	system    => true,
  }

  user { 'activemq':
    ensure     => present,
    allowdupe  => false,
    uid        => 92,
    gid        => 92,
    managehome => true,
    home       => $activemq::home,
    shell      => '/bin/bash',
    system     => true,
    require    => Group['activemq']
  }
  
  ensure_resource('package',["activemq-${activemq::version}","jdk"],{require => User['activemq'] })

}

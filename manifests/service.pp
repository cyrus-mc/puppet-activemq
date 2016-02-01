class activemq::service {

  service { 'activemq':
    ensure     => $activemq::service_enabled,
    enable     => $activemq::service_boot,
    hasstatus  => true,
    hasrestart => true,
  }
}
class activemq::service {

  # parent class must be defined
  if !defined(Class['::activemq']) {
    fail("${module_name} : You must declare class ${module_name} before ${module_name}::service")
  }

  # validate parameters
  validate_bool($::activemq::service_enable)

  if ! ($::activemq::service_ensure in [ 'running', 'stopped' ]) {
    fail("${module_name} : service_ensure value must be either running or stopped : supplied value $::activemq::service_ensure")
  }

  service { 'activemq-service':
    ensure     => $::activemq::service_ensure,
    name       => $::activemq::params::service_name,
    enable     => $::activemq::service_enable,
    hasrestart => $::activemq::params::service_hasrestart
  }

}

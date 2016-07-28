class activemq::package {

  # parent class must be defined
  if ! defined(Class['::activemq']) {
    fail("${module_name} : You must declare class ${module_name} before ${module_name}::package")
  }

  # validate parameters
  if ! is_string($::activemq::params::package) and ! is_array($::activemq::params::package) {
    fail("${module_name} : package must be a string of an array of packages to install")
  }

  # install necessary package(s)
  package { $::activemq::params::package:
    ensure => $::activemq::package_ensure
  }

}

class activemq (
  $activemq_home               = $::activemq::params::activemq_home,
  $activemq_data               = $::activemq::params::activemq_data,
  $activemq_opts_memory        = $::activemq::params::activemq_opts_memory,
  $activemq_opts               = undef,
  $networkConnectors           = $::activemq::params::networkConnectors,
  $package_ensure              = $::activemq::params::package_ensure,
  $source                      = $::activemq::params::source,
  $source_dir                  = $::activemq::params::source_dir,
  $service_enable              = $::activemq::params::service_enable,
  $service_ensure              = $::activemq::params::service_ensure,
  $source                      = undef,
  $source_dir                  = undef,
  $template                    = $::activemq::params::template,
  $transportConnectors         = $::activemq::params::transportConnectors,
  ) inherits activemq::params {

  include ::activemq::package
  include ::activemq::service
  include ::activemq::config

  # set order
  Class[ '::activemq::package' ] -> Class[ '::activemq::config' ]

}

class activemq (
  $activemq_home               = $::activemq::params::activemq_home,
  $activemq_data               = $::activemq::params::activemq_data,
  $activemq_opts               = undef,
  $activemq_opts_memory        = $::activemq::params::activemq_opts_memory,
  $activemq_sunjmx_start       = undef,
  $networkConnectors           = $::activemq::params::networkConnectors,
  $package_ensure              = $::activemq::params::package_ensure,
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

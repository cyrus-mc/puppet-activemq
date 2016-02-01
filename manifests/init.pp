class activemq(
  $user                        = $activemq::params::user,
  $home                        = $activemq::params::home,
  $confdir                     = $activemq::params::confdir,
  $configfile                  = $activemq::params::configfile,
  $data                        = $activemq::params::data,
  $tmp                         = $activemq::params::tmp,
  $memory                      = $activemq::params::memory,
  $version                     = $activemq::params::version,
  $networkConnectors           = {},
  $default_networkConnectors   = $activemq::params::default_networkConnectors,
  $transportConnectors         = {},
  $default_transportConnectors = $activemq::params::default_transportConnectors,
  $mount                       = {},
  $default_mount               = $activemq::params::default_mount,
  $cluster_enabled             = false,
  $service_enabled             = true,
  $service_boot                = true,
  $uninstall                   = false,
) inherits activemq::params {

  validate_hash($default_transportConnectors)
  validate_hash($transportConnectors)

  validate_hash($default_networkConnectors)
  validate_hash($networkConnectors)

  validate_hash($default_mount)
  validate_hash($mount)


  $real_transportConnectors = merge($default_transportConnectors,$transportConnectors)
  $real_networkConnectors = merge($default_networkConnectors,$networkConnectors)
  $real_mount = merge($default_mount,$mount)


  anchor {'activemq::begin':}
  anchor {'activemq::end':}

  Anchor['activemq::begin'] ->
  class {'activemq::install':} ->
  class {'activemq::config':} ~>
  class {'activemq::service':} ->
  Anchor['activemq::end']

}
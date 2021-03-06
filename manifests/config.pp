class activemq::config { 

  # parent class must be defined
  if ! defined(Class['::activemq']) {
    fail("${module_name} : You must declare class ${module_name} before ${module_name}::config")
  }

  # validate parameters
  validate_hash($::activemq::transportConnectors)
  validate_hash($::activemq::networkConnectors)

  # only allowed to specify a source or content
  if $::activemq::source and $::activemq::template {
    fail("${module_name} : You must provide either 'source' or 'content', not both")
  }

  # resource defaults
  File {
    owner  => $::activemq::params::file_owner,
    group  => $::activemq::params::file_group,
    mode   => $::activemq::params::file_mode,
    notify => Service[ 'activemq-service' ]
  }

  file { "${::activemq::params::config_path}/activemq.xml":
    source  => $::activemq::source,
    content => epp("${::activemq::template}.epp")
  }

  file { "/etc/default/activemq":
    content => epp("${module_name}/default.epp")
  }

  # set link on data
  file { "${::activemq::activemq_home}/data":
    ensure  => 'link',
    target  => "${::activemq::activemq_data}",
    replace => true
  }

  # deploy directory of configuration files
  # recursively evaluates templates
  if $::activemq::source_dir {
    recursive_directory { "${::activemq::params::config_path}":
      source_dir => "${::activemq::source_dir}",
      dest_dir   => "${::activemq::params::config_path}",
      owner      => "${::activemq::params::file_owner}",
      group      => "${::activemq::params::file_group}",
      file_mode  => "${::activemq::params::file_mode}",
      dir_mode   => "${::activemq::params::file_mode}"
    }
  }

}

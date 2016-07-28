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
    content => template("${::activemq::template}")
  }

  file { "/etc/default/activemq":
    content => template("${module_name}/default.erb")
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

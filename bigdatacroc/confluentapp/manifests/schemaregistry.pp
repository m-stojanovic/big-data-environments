class confluentapp::schemaregistry (
  $package,
  $version,
  $url,
  $kafkastoretopic,
  $bootstrapservers,
  $groupid,
  $port,
  $hname,
) {

  include 'confluentapp'
  motd::register{ 'confluentapp::schemaregistry': }

  package { $package:
    ensure => $version,
  }

  apt::pin { $package:
    packages => $package,
    version => $version,
    priority => '1001',
  }

  file { '/etc/schema-registry/schema-registry.properties':
    ensure  => present,
    content => template ('confluentapp/schemaregistry/schema-registry.properties.erb'),
    owner   => root,
    group   => root,
  }
  
  file { '/etc/schema-registry/connect-avro-distributed.properties':
    ensure  => present,
    content => template ('confluentapp/schemaregistry/connect-avro-distributed.properties.erb'),
    owner   => root,
    group   => root,
  }

  file { '/etc/schema-registry/connect-avro-standalone.properties':
    ensure  => present,
    content => template ('confluentapp/schemaregistry/connect-avro-standalone.properties.erb'),
    owner   => root,
    group   => root,
  }

  # Place service file
  file { '/lib/systemd/system/confluent-schema-registry.service':
    ensure => present,
    source => 'puppet:///modules/confluentapp/confluent-schema-registry.service',
  }
  
  file {'/etc/rsyslog.d/confluent-schema-registry.conf':
    ensure => present,
    source => 'puppet:///modules/confluentapp/confluent-schema-registry.conf',
    notify => Service['rsyslog','confluent-schema-registry'],
  }

  service { 'confluent-schema-registry':
    enable => true,
    ensure => 'running',
    require => File['/lib/systemd/system/confluent-schema-registry.service','/etc/rsyslog.d/confluent-schema-registry.conf'],
  }

}

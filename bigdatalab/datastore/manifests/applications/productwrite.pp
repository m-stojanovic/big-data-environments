# Datastore product write application
class datastore::applications::productwrite(
  $package,
  $version,
  $announce_path,
  $announce_timeout,
  $topic,
  $shard,
  $enabled,
  $admin_port,
  $service_port,
  $processor,
  $encoder,
  $protocol,
  $log_level,
  $log_stdout,
  $log_stderr,
) {

  motd::register{ 'datastore::productwrite': }

  # Main dependencies 
  include datastore

  package { $package:
    ensure => $version,
    notify  => Service['datastore-product-write'],
  }
  
  apt::pin { 'datastore-product-write':
    packages => 'datastore-product-write',
    version  => $version,
    priority => '1001',
  }
  
  file { '/opt/datastore-product-write/application.conf':
    ensure  => present,
    content => template ('datastore/opt/product-write/application.conf.yml.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0660',
    require =>  Package[ $package ],
    notify  => Service['datastore-product-write'],
  }
  
  file { '/opt/datastore-product-write/logback.xml':
    ensure  => present,
    content => template ('datastore/opt/product-write/logback.xml.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0660',
    require =>  Package[ $package ],
    notify  => Service['datastore-product-write'],
  }
   
  file { '/etc/default/datastore-product-write':
    ensure  => present,
    content => template ('datastore/etc/product-write/datastore-product-write.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0660',
    notify  => Service['datastore-product-write'],
  }

  service { 'datastore-product-write':
    ensure  =>  'running',
    enable  =>  true,
    require =>  Package[ $package ],
  }


}

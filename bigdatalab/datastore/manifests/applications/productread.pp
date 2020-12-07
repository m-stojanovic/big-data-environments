# Datastore product read application
class datastore::applications::productread(
  $package,
  $version,
  $announce_path,
  $announce_timeout,
  $shard,
  $enabled,
  $admin_port,
  $service_port,
  $protocol,
  $log_level,
  $log_stdout,
  $log_stderr
) {

  motd::register{ 'datastore::productread': }

  # Main dependencies 
  include datastore

  package { $package:
    ensure => $version,
    notify  => Service['datastore-product-read'],
  }
  
  apt::pin { 'datastore-product-read':
    packages => 'datastore-product-read',
    version  => $version,
    priority => '1001',
  }
  
  file { '/opt/datastore-product-read/application.conf':
    ensure  => present,
    content => template ('datastore/opt/product-read/application.conf.yml.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0660',
    require =>  Package[ $package ],
    notify  => Service['datastore-product-read'],
  }
  
  file { '/opt/datastore-product-read/logback.xml':
    ensure  => present,
    content => template ('datastore/opt/product-read/logback.xml.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0660',
    require =>  Package[ $package ],
    notify  => Service['datastore-product-read'],
  }
   
  file { '/etc/default/datastore-product-read':
    ensure  => present,
    content => template ('datastore/etc/product-read/datastore-product-read.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0660',
    notify  => Service['datastore-product-read'],
  }

  service { 'datastore-product-read':
    ensure  =>  'running',
    enable  =>  true,
    require =>  Package[ $package ],
  }


}

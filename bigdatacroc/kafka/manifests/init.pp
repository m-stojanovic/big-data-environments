class kafka(
  $auto_create_topics_enable,
  $broker_port,
  $brokers,
  $classpath,
  $default_replication_factor,
  $delete_topic_enable,
  $enabled,
  $heap_opts,
  $java_home,
  $java_opts,
  $jmx_port,
  $jvm_performance_opts,
  $log_cleanup_interval_mins,
  $log_cleanup_policy,
  $log_dirs,
  $log_flush_interval_messages,
  $log_flush_interval_ms,
  $log_retention_bytes,
  $log_retention_hours,
  $log_segment_bytes,
  $log4jlogdir,
  $metrics_properties,
  $nofiles_ulimit,
  $num_io_threads,
  $num_network_threads,
  $num_partitions,
  $num_replica_fetchers,
  $package,
  $replica_fetch_max_bytes,
  $replica_lag_max_messages,
  $replica_lag_time_max_ms,
  $replica_socket_receive_buffer_bytes,
  $replica_socket_timeout_ms,
  $socket_receive_buffer_bytes,
  $socket_request_max_bytes,
  $socket_send_buffer_bytes,
  $version,
  $zookeeper_chroot,
  $zookeeper_connection_timeout_ms,
  $zookeeper_session_timeout_ms,
){
  
  motd::register { 'kafka': }
  
  include 'dsglobals'
  require 'java'
  
  $broker_id   = $brokers[$fqdn]['id']

  $package.each |$p| {   
    
    package { $p:
      ensure => $version,
    }

    apt::pin { $p:
      packages => $p,
      version  => $version,
      priority => 1001,
    }

  }
  
  file { $log_dirs:
    ensure => directory,
    owner => 'kafka',
    group => 'kafka',
    mode => '0755',
  }

  file { '/etc/default/kafka-server':
    ensure  => file,
    content => template('kafka/etc/kafka-server.default.erb'),
  }
    
  file { '/etc/kafka/conf/server.properties':
    ensure  => file,
    content => template('kafka/etc/server.properties.erb'),
  }

  file { '/var/spool/kafka':
    ensure  => 'directory',
    owner   => 'kafka',
    group   => 'kafka',
    mode    => '0755',
  }

  file { '/etc/kafka/conf/log4j.properties':
    ensure  => file,
    content => template('kafka/etc/log4j.properties.erb'),
  }

  service { 'kafka-server':
    ensure     => 'running',
    require    => File['/etc/kafka/conf/server.properties','/etc/kafka/conf/log4j.properties','/etc/default/kafka-server', $log_dirs ],
    hasrestart => true,
    hasstatus  => true,
  }


}


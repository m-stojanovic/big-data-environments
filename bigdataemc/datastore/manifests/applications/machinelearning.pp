class datastore::applications::machinelearning (
  $packages,
  $es_index_prefix,
  $tenants,
  $snapshot_period_start,
  $snapshot_period_end,
  $snapshot_period_fixed_start,
  $snapshot_date,
  $topic,
  $hbase_znode,
  $hdfs_host,
  $hdfs_port,
) {

  motd::register{ 'datastore::machinelearning': }

  # Main dependencies
  include datastore

  $packages.each |$n,$a| {
    if ! defined(Package[$n]) {
      package { $n:
        * => $a,
      }

      apt::pin { $n:
        packages => $n,
        version  => $a['ensure'],
        priority => '1001',
      }

      file { "/etc/$n/application.conf":
        ensure  => present,
        content => template("datastore/etc/$n/application.conf.erb"),
        require => Package[ $n ],
      }

      file { "/etc/$n/weekly/application.conf":
        ensure  => present,
        content => template("datastore/etc/$n/weekly/application.conf.erb"),
        require => Package[ $n ],
      }

    }
  }

}

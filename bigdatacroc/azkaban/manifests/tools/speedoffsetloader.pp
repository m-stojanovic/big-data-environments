class azkaban::tools::speedoffsetloader(
  $package,
  $version,
  $config,
) {

  include 'dsglobals'

  motd::register { 'azkaban::tools::speedoffsetloader': }

  package{ $package:
    ensure => $version,
  }

  apt::pin { $package:
    packages => $package,
    version  => $version,
    priority => '1001',
  }

  file { '/opt/speed-offset-loader/conf/speed-offset-loader.properties':
    ensure => file,
    content => template('azkaban/tools/speedoffsetloader/speed-offset-loader.properties.erb'),
  }

}

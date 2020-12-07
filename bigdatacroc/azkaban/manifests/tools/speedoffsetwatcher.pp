class azkaban::tools::speedoffsetwatcher(
  $package,
  $version,
  $config,
) {

  include 'dsglobals'

  motd::register { 'azkaban::tools::speedoffsetwatcher': }

  package{ $package:
    ensure => $version,
  }

  apt::pin { $package:
    packages => $package,
    version  => $version,
    priority => '1001',
  }
  
  file { '/opt/speed-offset-watcher/conf/speed-offset-watcher.properties':
    ensure => file,
    content => template('azkaban/tools/speedoffsetwatcher/speed-offset-watcher.properties.erb'),
  }

}

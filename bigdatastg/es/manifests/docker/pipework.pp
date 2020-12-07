# Define service that will start after docker run command to assure that
# we can easily restart docker using systemd script generated by puppetlabs/docker
# while also having pipeworks depended on it.

define es::docker::pipework (
  $interface,
  $ipaddress,
  $mask,
  $gateway,
 
) {

  file { "/lib/systemd/system/$name-pipework.service":
    ensure => file,
    content => template('es/docker/service.erb'),
    owner => 'root',
    group => 'root',
    mode => '0644',
  }  
  
   service { "$name-pipework.service":
    enable => true,
  }

}

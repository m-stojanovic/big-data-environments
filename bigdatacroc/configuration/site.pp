# Provide default to package so that it depends on apt update
Package {
  provider => 'apt',
  require => Class['apt::update'],
}

node /^mp13dses*/ {
  
  $hostroles.each |$role| {
    include "roles::${role}"
  }

}

# DSAPI Maintainer with Confluent kafka rest and heartbeat
node mp13dsapi01 {
  
  $hostroles.each |$role| {
    include "roles::${role}"
  }

}

# DSAPI with Confluent kafka rest and heartbeat
node mp13dsapi02 {
  
  $hostroles.each |$role| {
    include "roles::${role}"
  }
include nginx
}

# Azkaban + BB
node mp13azkaban01 {

  $hostroles.each |$role| {
    include "roles::${role}"
  }
  
  include 'azkaban::config'

}

# API Zookeeper nodes
node /^mp13dsapz/ {
  
  $hostroles.each |$role| {
    include "roles::${role}"
  }
  
}

# Hadoop Zookeeper node
node /^mp13dshdz/ {
  
  $hostroles.each |$role| {
    include "roles::${role}"
  }
  
}

# Kafka
node /^mp13dsqueue/ {
  
  $hostroles.each |$role| {
    include "roles::${role}"
  }
  
}

# DFS Master 1
node mp13dshdm01 {
  
  $hostroles.each |$role| {
    include "roles::${role}"
  }
  
}

# DFS MAster 2
node mp13dshdm02 {
  
  $hostroles.each |$role| {
    include "roles::${role}"
  }
  
}

node /^mp13dshdp/ {
  
  $hostroles.each |$role| {
    include "roles::${role}"
  }
  
}

node default {
  include roles::base
}

#####

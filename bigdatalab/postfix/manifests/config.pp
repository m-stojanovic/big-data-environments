class postfix::config (
  $files,
) {

  motd::register { 'postfix::config': }

  $files.each |$cf, $variables| {
    file { "${cf}":
      ensure => file,
      content =>  template("${module_name}${cf}.erb"),
    }
  }
}

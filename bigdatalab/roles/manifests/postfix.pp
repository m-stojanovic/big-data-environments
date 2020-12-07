class roles::postfix{

  motd::register { 'roles::postfix': }

  include postfix, postfix::config

}

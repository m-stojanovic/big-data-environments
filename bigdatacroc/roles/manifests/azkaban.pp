class roles::azkaban{
  include 'azkaban'
  include 'azkaban::config'
  include 'azkaban::tools::speedoffsetloader'
  
  Class['azkaban'] -> Class['azkaban::config']
  
}

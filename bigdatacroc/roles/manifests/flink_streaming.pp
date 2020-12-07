class roles::flink_streaming {

  include hadoop::roles::flinkmanager
  include flink, flink::manager, flink::applications
  include azkaban::tools::speedoffsetwatcher

}

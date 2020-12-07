---
# flink packages
flink::packages:
  flink:
    ensure: '1.9.2-2'
  flink-metrics-libs:
    ensure: '0.0.6'

flink::manager::apps:
  flink_dmp:
    defaults:
      yarn_session_container_suffix: jobs
      yarn_session_tm_memory: 3072
      flink_run_command: '/opt/dmp-events-flink/dmp-events-flink-*-fat.jar --config /opt/dmp-events-flink/conf/config.yml'
  flink_elasticsearch-user:
      defaults:
        yarn_session_jm_memory: 2048
        yarn_session_tm_memory: 10240
        yarn_session_tm_slots: 8
        flink_additional_parameters: 'containerized.heap-cutoff-ratio=0.20;taskmanager.memory.fraction=0.3;taskmanager.network.memory.fraction=0.3;taskmanager.network.memory.max=3gb'
      prime:
        flink_run_command: '/opt/speedlayer-flink-user-elastic/speedlayer-flink-user-elastic-*-fat.jar --config /opt/speedlayer-flink-user-elastic/conf/config.yml'
      fast:
        flink_run_command: '/opt/speedlayer-flink-user-elastic/speedlayer-flink-user-elastic-*-fat.jar --config /opt/speedlayer-flink-user-elastic/conf/config-fast.yml'
      png:
        flink_run_command: '/opt/speedlayer-flink-user-elastic/speedlayer-flink-user-elastic-*-fat.jar --config /opt/speedlayer-flink-user-elastic/conf/config-png.yml'
      reindex:
        flink_run_command: ''
  flink_event-engine:
    defaults:
      yarn_session_tm_no: 6
      yarn_session_tm_memory: 1536
      yarn_session_tm_slots: 4
      flink_run_command: '/opt/event-engine-flink/event-engine-flink-*.jar --config /opt/event-engine-flink/conf/config.yml'
  flink_hbase:
    defaults:
      yarn_session_container_suffix: 'jobs'
      yarn_session_tm_memory: 10240
      yarn_session_tm_slots: 8
      flink_run_command: '/opt/speedlayer-flink-user-hbase/speedlayer-flink-user-hbase-*-fat.jar --config /opt/speedlayer-flink-user-hbase/conf/config.yml'
      flink_additional_parameters: 'containerized.heap-cutoff-ratio=0.15;taskmanager.memory.fraction=0.3;taskmanager.network.memory.fraction=0.3;taskmanager.network.memory.max=3gb'
  flink_hbase-userresponse:
    defaults:
      yarn_session_tm_memory: 4096
      yarn_session_tm_slots: 2
      flink_run_command: '/opt/speedlayer-flink-userresponse-hbase/speedlayer-flink-userresponse-hbase-*-fat.jar --config /opt/speedlayer-flink-userresponse-hbase/conf/config.yml'
  flink_interaction-planner:
    defaults:
      yarn_session_tm_no: 4
      yarn_session_tm_memory: 2048
      yarn_session_tm_slots: 4
      flink_run_command: '/opt/interaction-planner-flink/interaction-planner-flink-*-fat.jar --config /opt/interaction-planner-flink/conf/config.yml'
  flink_locking-injection:
    defaults:
      yarn_session_tm_memory: 2048
      yarn_session_tm_slots: 2
      flink_run_command: '/opt/speedlayer-flink-locking-injection/speedlayer-flink-locking-injection-*-fat.jar --config /opt/speedlayer-flink-locking-injection/conf/config.yml'
  flink_hbase-mobileresponses:
    defaults:
      yarn_session_tm_memory: 4096
      yarn_session_tm_slots: 4
      flink_run_command: '/opt/speedlayer-flink-mobile-statistics/speedlayer-flink-mobile-statistics-*-fat.jar --config /opt/speedlayer-flink-mobile-statistics/conf/config.yml'
  flink_kafka-reloader:
    defaults:
      yarn_session_tm_memory: 4096
      yarn_session_tm_slots: 1
      flink_run_command: '/opt/kafka-reloader/kafka-reloader-*-fat.jar --config /opt/kafka-reloader/conf/config.yml'
  flink_mct_processor:
    defaults:
      yarn_session_tm_memory: 4096
      yarn_session_tm_slots: 1
      flink_run_command: '/opt/mct-processor-flink/mct-processor-flink-*-fat.jar --config /opt/mct-processor-flink/conf/config.yml'
  flink_phone-hbase:
    defaults:
      yarn_session_tm_memory: 2048
      yarn_session_tm_slots: 2
      flink_run_command: '/opt/speedlayer-flink-phone-hbase/speedlayer-flink-phone-hbase-*-fat.jar --config /opt/speedlayer-flink-phone-hbase/conf/config.yml'
  flink_relateddata:
    defaults:
      yarn_session_tm_memory: 10240
      yarn_session_tm_slots: 8
      flink_additional_parameters: 'containerized.heap-cutoff-ratio=0.15;taskmanager.memory.fraction=0.3;taskmanager.network.memory.fraction=0.3;taskmanager.network.memory.max=3gb'
    hbase:
      flink_run_command: '/opt/speedlayer-flink-relateddata-hbase/speedlayer-flink-relateddata-hbase-*-fat.jar --config /opt/speedlayer-flink-relateddata-hbase/conf/config.yml'
    hbase-locking:
      flink_run_command: '/opt/speedlayer-flink-relateddata-hbase/speedlayer-flink-relateddata-hbase-*-fat.jar --config /opt/speedlayer-flink-relateddata-hbase/conf/config.yml --name hbase-locking-handling --customer.whitelist.path.enable false --hbase.table.name relateddata-speed-tmp --customer.blacklist.path /mds/snapshots/rd_whitelist.conf --customer.blacklist.path.enable true'
    hbase-tmp:
      flink_run_command: ''
    elastic:
        flink_run_command: '/opt/speedlayer-flink-relateddata-elastic/speedlayer-flink-relateddata-elastic-*-fat.jar --config /opt/speedlayer-flink-relateddata-elastic/conf/config.yml'
  flink_webtrekk-segment:
    defaults:
      yarn_session_tm_memory: 2048
      yarn_session_tm_slots: 1
      flink_run_command: '/opt/webtrekk-segment-flink/webtrekk-segment-flink-*-fat.jar --config /opt/webtrekk-segment-flink/conf/config.yml'
  flink_hbase-productcatalog:
    defaults:
      yarn_session_tm_memory: 2048
      yarn_session_tm_slots: 2
      flink_run_command: '/opt/speedlayer-flink-product-catalog/speedlayer-flink-product-catalog-*-fat.jar --config /opt/speedlayer-flink-product-catalog/conf/config.yml'

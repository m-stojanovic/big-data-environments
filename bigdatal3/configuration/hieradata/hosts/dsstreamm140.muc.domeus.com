---
# flink packages
flink::packages:
  flink:
    ensure: '1.9.2-2'
  flink-metrics-libs:
    ensure: '0.0.6'

# flink manager configuration
flink::manager::apps:
  flink_event-engine:
    defaults:
      yarn_session_tm_memory: 1536
      yarn_session_tm_slots: 4
      flink_run_command: '/opt/event-engine-flink/event-engine-flink-*.jar --config /opt/event-engine-flink/conf/config.yml'
  flink_hbase:
    defaults:
      yarn_session_container_suffix: 'jobs'
      yarn_session_tm_memory: 10240
      yarn_session_tm_slots: 16
      flink_run_command: '/opt/speedlayer-flink-user-hbase/speedlayer-flink-user-hbase-*-fat.jar --config /opt/speedlayer-flink-user-hbase/conf/config.yml'
      flink_additional_parameters: 'containerized.heap-cutoff-ratio=0.15;taskmanager.memory.fraction=0.3;taskmanager.network.memory.fraction=0.3;taskmanager.network.memory.max=3gb'
  flink_elasticsearch-user:
    defaults:
      yarn_session_jm_memory: 2048
      yarn_session_tm_memory: 10240
      yarn_session_tm_slots: 8
      flink_additional_parameters: 'containerized.heap-cutoff-ratio=0.25;taskmanager.memory.fraction=0.3;taskmanager.network.memory.fraction=0.3;taskmanager.network.memory.max=3gb'
    prime:
      flink_run_command: '/opt/speedlayer-flink-user-elastic/speedlayer-flink-user-elastic-*-fat.jar --config /opt/speedlayer-flink-user-elastic/conf/config.yml'
    bigtenants:
      flink_run_command: '/opt/speedlayer-flink-user-elastic/speedlayer-flink-user-elastic-*-fat.jar --config /opt/speedlayer-flink-user-elastic/conf/config_bigtenants.yml'
    reindex:
      flink_run_command: ''
  flink_dmp:
    defaults:
      yarn_session_container_suffix: jobs
      yarn_session_tm_memory: 3072
      flink_run_command: '/opt/dmp-events-flink/dmp-events-flink-*-fat.jar --config /opt/dmp-events-flink/conf/config.yml'
  flink_hbase-statistics:
    defaults:
      yarn_session_tm_slots: 2
    regular:
      yarn_session_tm_memory: 6144
      flink_run_command: '/opt/speedlayer-flink-statistics/speedlayer-flink-statistics-*-fat.jar --config /opt/speedlayer-flink-statistics/conf/config.yml'
    recovery:
      yarn_session_tm_memory: 4096
      flink_run_command: '/opt/speedlayer-flink-statistics/speedlayer-flink-statistics-*-fat.jar --config /opt/speedlayer-flink-statistics/conf/config-recovery.yml'
    sendout:
      yarn_session_tm_slots: 4
      yarn_session_tm_memory: 7168
      flink_run_command: '/opt/speedlayer-flink-statistics/speedlayer-flink-statistics-*-fat.jar --config /opt/speedlayer-flink-statistics/conf/config-sendout.yml'
  flink_hbase-productcatalog:
    defaults:
      yarn_session_tm_memory: 2048
      yarn_session_tm_slots: 2
      flink_run_command: '/opt/speedlayer-flink-product-catalog/speedlayer-flink-product-catalog-*-fat.jar --config /opt/speedlayer-flink-product-catalog/conf/config.yml'
  flink_webtrekk-segment:
    defaults:
      yarn_session_tm_memory: 2048
      yarn_session_tm_slots: 1
      flink_run_command: '/opt/webtrekk-segment-flink/webtrekk-segment-flink-*-fat.jar --config /opt/webtrekk-segment-flink/conf/config.yml'

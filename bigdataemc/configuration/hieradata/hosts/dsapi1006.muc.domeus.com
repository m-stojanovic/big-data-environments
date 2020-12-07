---
lookup_options:
  datastore::applications::etlservicemaintainer::templates:
    merge: deep

datastore::applications::etlservicemaintainer::templates:
  'application.properties':
    etl.server.flink.propertiesFilePath: '/flink/snapshots_1006.properties'
    etl.server.flink.supportedJobTypes: 'SWEEPER_COMPACT,SWEEPER_SWEEP,SC,RDE,SDE,ADE,CE,SUDE,RDI,SC_MONTHLY'
    etl.server.flink.job.scheduler.sc_monthly.enabled: 'true'
    etl.server.flink.job.scheduler.sc_monthly.cron: '0 0 10 22-28 * MON'
    flink.jobmanager.max.slots.number: 128

profiles::firewall::rules::ipv4:
  '800 Allow Kafka hearthbeat':
    chain: INPUT
    proto: udp
    dport: 694
    action: 'accept'
  '801 allow 8182 - kafka rest proxy':
    chain: INPUT
    proto: tcp
    dport: 8182
    action: accept
  '802 allow port 80 - for DMC access via proxy':
    chain: INPUT
    proto: tcp
    dport: 80
    action: accept
  '803 allow port 8443 - for DMP access via proxy':
    chain: INPUT
    proto: tcp
    dport: 8443
    action: accept

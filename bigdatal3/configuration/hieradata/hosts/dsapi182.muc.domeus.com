---
lookup_options:
  datastore::applications::etlservicemaintainer::templates:
    merge: deep

datastore::applications::etlservicemaintainer::templates:
  'application.properties':
    etl.server.flink.propertiesFilePath: '/flink/snapshots_182.properties'
    etl.server.flink.supportedJobTypes: 'SWEEPER_COMPACT,SWEEPER_SWEEP,SC,RDE,SDE,ADE,CE,SUDE,RDI,SC_MONTHLY'
    etl.server.flink.job.scheduler.sweeper.enabled: 'true'
    etl.server.flink.job.scheduler.sc_monthly.enabled: 'true'
    etl.server.flink.job.scheduler.sc_monthly.cron: '0 0 10 22-28 * MON'
    etl.server.sweeper.cron: '0 30 10 1-7 * MON'
    flink.jobmanager.max.slots.number: 160

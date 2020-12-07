---
# snapshots flink-manager.sh -P crons
cron::job::multiple:
  snapshots_fm:
    jobs:
      - {
          minute: '0-50/10',
          user: snapshots,
          command: 'flink-manager.sh -i 1005 -P',
      }
      - {
          minute: '0-50/10',
          user: snapshots,
          command: 'flink-manager.sh -i 1006 -P',
      }
      - {
          minute: '0-50/10',
          user: snapshots,
          command: 'flink-manager.sh -i 1007 -P',
      }
      
# flink packages
flink::packages:
  flink:
    ensure: '1.9.2-1'
  flink-common-libs:
    ensure: '0.1.1'
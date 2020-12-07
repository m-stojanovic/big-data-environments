---
# snapshots flink-manager.sh -P crons
cron::job::multiple:
  snapshots_fm:
    jobs:
      - {
          minute: '0-50/10',
          user: snapshots,
          command: 'flink-manager.sh -i 181 -P',
      }
      - {
          minute: '0-50/10',
          user: snapshots,
          command: 'flink-manager.sh -i 182 -P',
      }

# flink packages
flink::packages:
  flink:
    ensure: '1.9.2-1'
  flink-common-libs:
    ensure: '0.1.1'

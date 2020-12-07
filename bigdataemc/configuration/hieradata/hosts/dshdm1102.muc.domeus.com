---
# snapshots flink-manager.sh -P crons
cron::job::multiple:
  snapshots_fm:
    jobs:
      - {
          minute: '5-55/10',
          user: snapshots,
          command: 'flink-manager.sh -i 1005 -P',
      }
      - {
          minute: '5-55/10',
          user: snapshots,
          command: 'flink-manager.sh -i 1006 -P',
      }
      - {
          minute: '5-55/10',
          user: snapshots,
          command: 'flink-manager.sh -i 1007 -P',
      }

---
# snapshots flink-manager.sh -P crons
cron::job::multiple:
  snapshots_fm:
    jobs:
      - {
          minute: '5-55/10',
          user: snapshots,
          command: 'flink-manager.sh -i 181 -P',
      }
      - {
          minute: '5-55/10',
          user: snapshots,
          command: 'flink-manager.sh -i 182 -P',
      }

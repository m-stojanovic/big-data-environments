---
apt::sources:
  "debian_confluent_io":
    location: http://image-priv.muc.domeus.com/apt/confluent/deb/5.3/
    release: stable
    repos: main
    key:
      id: 1A77041E0314E6C5A486524E670540C841468433
      source: http://image-priv.muc.domeus.com/apt/repo-keys/confluent-io.key

profiles::firewall::rules::ipv4:
  '801 allow 8181 - schema registry':
    chain: INPUT
    proto: tcp
    dport: 8181
    action: accept

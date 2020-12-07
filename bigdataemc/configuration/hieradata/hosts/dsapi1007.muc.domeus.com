profiles::firewall::rules::ipv4:
  '801 allow port 80 - for DMC access via proxy':
    chain: INPUT
    proto: tcp
    dport: 80
    action: accept
add masquerade rule:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - jump: MASQUERADE
    - o: eth0

remove rule that blocks returning packets:
  iptables.delete:
    - table: filter
    - jump: REJECT
    - reject-with: icmp-host-prohibited

run devstack:
  cmd.run:
    - name: /opt/stack/devstack/stack.sh
    - cwd: /opt/stack/devstack
    - runas: stack

add masquerade rule:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - jump: MASQUERADE
    - o: eth0

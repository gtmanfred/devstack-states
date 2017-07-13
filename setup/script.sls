run devstack:
  cmd.run:
    - name: /opt/stack/devstack/stack.sh | tee -a /devstack.log
    - cwd: /opt/stack/devstack
    - runas: stack
    - output_loglevel: quiet

add masquerade rule:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - jump: MASQUERADE
    - o: eth0

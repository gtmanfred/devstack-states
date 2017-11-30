dummy interface:
  cmd.run:
    - names:
      - ip link add dummy0 type dummy:
        - unless: ip link show dummy0
        - check_cmd: ip link show dummy0
      - ip addr add 172.16.0.1/24 dev dummy0:
        - unless: ip addr show dummy0 | grep 172.16.0.1

base:
  '*':
    - network.interface
    - setup.user
    - setup.packages
    - setup.script
    - network.iptables
    - setup.securitygroup
    - setup.image

setup user:
  user.present:
    - name: stack
    - home: /opt/stack
    - groups:
      - wheel

comment initial wheel in sudoers:
  file.comment:
    - name: /etc/ssh/sshd_config
    - regex: %wheel	ALL=(ALL)	ALL

uncomment NOPASSWD wheel:
  file.uncomment:
    - name: /etc/ssh/sshd_config
    - regex: %wheel	ALL=(ALL)	NOPASSWD: ALL

clone git repo:
  git.latest:
    - target: /opt/stack/devstack
    - name: git://github.com/openstack-dev/devstack.git
    - user: stack

  file.managed:
    - name: /opt/stack/devstack/local.conf
    - source: salt://local.conf
    - template: jinja

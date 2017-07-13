setup user:
  user.present:
    - name: stack
    - home: /opt/stack
    - groups:
      - wheel

comment initial wheel in sudoers:
  file.comment:
    - name: /etc/sudoers
    - regex: '%wheel'

uncomment NOPASSWD wheel:
  file.uncomment:
    - name: /etc/sudoers
    - regex: '%wheel.*NOPASSWD.*'

clone git repo:
  git.latest:
    - target: /opt/stack/devstack
    - name: git://github.com/openstack-dev/devstack.git
    - user: stack

  file.managed:
    - name: /opt/stack/devstack/local.conf
    - source: salt://local.conf
    - template: jinja

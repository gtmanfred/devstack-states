{%- load_yaml as rawmap %}
Debian:
  sudogrp: sudo
RedHat:
  sudogrp: wheel
{%- endload %}
{%- set config = salt['grains.filter_by'](rawmap, grain='os_family', merge=salt['config.get']('openstack:lookup')) %}
setup user:
  user.present:
    - name: stack
    - home: /opt/stack
    - groups:
      - {{config.sudogrp}}

comment initial {{config.sudogrp}} in sudoers:
  file.comment:
    - name: /etc/sudoers
    - regex: '%{{config.sudogrp}}'

NOPASSWD {{config.sudogrp}}:
  file.append:
    - name: /etc/sudoers
    - text: '%{{config.sudogrp}} ALL=(ALL) NOPASSWD: ALL'

clone git repo:
  git.latest:
    - target: /opt/stack/devstack
    - name: git://github.com/openstack-dev/devstack.git
    - user: stack
    - rev: stable/{{salt.config.get('openstack:version', 'pike')}}

  file.managed:
    - name: /opt/stack/devstack/local.conf
    - source: salt://local.conf
    - template: jinja

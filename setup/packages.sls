{%- load_yaml as rawmap %}
Debian:
  packages:
    - python-pip
    - python-dev
    - git
RedHat:
  packages:
    - python-pip
    - python-devel
    - git
{%- endload %}
{%- set config = salt['grains.filter_by'](rawmap, grain='os_family', merge=salt['config.get']('openstack:lookup')) %}

{%- if salt.grains.get('os_family') == 'RedHat' %}
epel-release:
  pkg:
    - latest
{%- endif %}

extra packages:
  pkg.latest:
    - pkgs: {{config.packages}}
    - reload_modules: True

pip package:
  pip.installed:
    - name: tornado>=4.5.2

{%- if salt.grains.get('os_family') == 'RedHat' %}
epel-release:
  pkg:
    - latest
{%- endif %}

git:
  pkg.latest:
    - reload_modules: True

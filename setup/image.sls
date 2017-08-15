unzip image:
  file.managed:
    - name: /alpine.qcow2.xz
    - source: salt://alpine.qcow2.xz
    - unless: test -f /alpine.qcow2
  cmd.run:
    - name: xz -d -T 0 /alpine.qcow2.xz
    - onchanges:
      - file: unzip image

setup glance image:
  cmd.run:
    - runas: stack
    - env:
      - OS_PROJECT_DOMAIN_ID: default
      - OS_REGION_NAME: RegionOne
      - OS_USER_DOMAIN_ID: default
      - OS_PROJECT_NAME: admin 
      - OS_IDENTITY_API_VERSION: 3
      - OS_PASSWORD: secret
      - OS_AUTH_TYPE: password
      - OS_AUTH_URL: http://{{salt.network.ip_addrs(interface=eth0)|first}}/identity
      - OS_USERNAME: admin
      - OS_TENANT_NAME: admin
      - OS_VOLUME_API_VERSION: 2
    - name: openstack image create alpine --file /alpine.qcow2 --disk-format qcow2 --container-format bare --public

remove invisible demo user:
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
      - OS_AUTH_URL: http://{{salt.network.ipaddrs(cidr='10.128.0.0/24')|first}}/identity
      - OS_USERNAME: admin
      - OS_TENANT_NAME: admin
      - OS_VOLUME_API_VERSION: 2
    - name: openstack project delete invisible_to_admin

stop firewalld:
  service.dead:
    - name: firewalld
    - enable: false

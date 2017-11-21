run devstack:
  cmd.run:
    - name: FORCE=yes /opt/stack/devstack/stack.sh &> /opt/stack/devstack.log
    - cwd: /opt/stack/devstack
    - env:
      - FORCE: 'yes'
    - runas: stack
    - shell: /bin/bash
    - ignore_timeout: True
    - timeout: 2000000

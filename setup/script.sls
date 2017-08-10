run devstack:
  cmd.run:
    - name: /opt/stack/devstack/stack.sh &> /devstack.log
    - cwd: /opt/stack/devstack
    - runas: stack
    - shell: /bin/bash
    - ignore_timeout: True
    - timeout: 2000000

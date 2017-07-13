run devstack:
  cmd.run:
    - name: /opt/stack/devstack/stack.sh
    - cwd: /opt/stack/devstack
    - runas: stack
    - shell: /bin/bash
    - use_vt: True

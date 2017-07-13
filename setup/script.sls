run devstack:
  cmd.run:
    - name: /opt/stack/devstack/stack.sh
    - cwd: /opt/stack/devstack
    - runas: stack
    - shell: /bin/bash
    - env:
      - VERBOSE: false

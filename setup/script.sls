run devstack:
  cmd.run:
    - name: /opt/stack/devstack/stack.sh
    - cwd: /opt/stack/devstack
    - runas: stack
    - shell: /bin/bash
    - python_shell: True
    - use_vt: True
    - output_loglevel: quiet

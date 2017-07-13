run devstack:
  cmd.run:
    - name: /opt/stack/devstack/stack.sh | tee -a /devstack.log
    - cwd: /opt/stack/devstack
    - runas: stack
    - output_loglevel: quiet

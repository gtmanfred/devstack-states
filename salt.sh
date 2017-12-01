#!/bin/bash
# gcloud compute instances create salt \
#    --image-family centos-7 \
#    --image-project centos-cloud \
#    --metadata-from-file startup-script=salt.sh \
while ! getent passwd daniel; do sleep 1; done
groupadd salt
gpasswd -a daniel salt
directories=(/etc/salt /var/cache/salt /var/log/salt /var/run/salt /etc/openstack /etc/salt/cloud.{providers,profiles,deploy}.d)
mkdir -p "${directories[@]}"
yum install -y python-pip python-devel gcc git systemd-python
sudo -u daniel pip install --user --src /home/daniel/src -e git+git://github.com/gtmanfred/salt.git@shade#egg=salt shade
for dir in minion master; do
    cp -a "/home/daniel/src/salt/pkg/salt-${dir}.service" /etc/systemd/system/
    mkdir "/etc/systemd/system/salt-${dir}.service.d"
    tee "/etc/systemd/system/salt-${dir}.service.d/user.conf" <<HERE
[Service]
User=daniel
ExecStart=
ExecStart=/home/daniel/.local/bin/salt-${dir}
HERE
    tee "/etc/salt/${dir}" <<HERE
user: daniel
HERE
done
tee /etc/openstack/clouds.yml <<HERE
clouds:
 democloud:
   region_name: RegionOne
   auth:
     username: 'demo'
     password: secret
     project_name: 'demo'
     auth_url: 'http://$(getent hosts openstack | awk '{print $1}')/identity'
HERE
tee /etc/salt/cloud.deploy.d/alpine.sh <<HERE
#!/bin/bash
mkdir -p /etc/salt/pki/minion
mv /tmp/.saltcloud-*/minion /etc/salt/minion
mv /tmp/.saltcloud-*/minion* /etc/salt/pki/minion/
apk add --update --no-progress salt-minion
rc-update add salt-minion default
rc-service salt-minion start
HERE
tee /etc/salt/cloud <<HERE
minion:
  master: $(getent ahostsv4 salt| awk '/STREAM/ {print $1}')
HERE
tee /etc/salt/cloud.providers.d/openstack.conf <<HERE
openstack:
  driver: openstack
  cloud: democloud
  region_name: RegionOne
HERE
tee /etc/salt/cloud.profiles.d/alpine.conf <<HERE
alpine:
  provider: openstack
  size: ds512M
  image: alpine
  key_name: mykey
  ssh_key_file: /home/daniel/.ssh/id_rsa
  ssh_username: alpine
  script: alpine
  ssh_interface: floating_ips
HERE
chmod -R 2775 "${directories[@]}"
chgrp -R salt "${directories[@]}"
systemctl enable --now salt-master salt-minion

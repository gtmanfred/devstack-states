# gcloud compute instances create \
#    --image-family ubuntu-1604-lts \
#    --image-project ubuntu-os-cloud \
#    --metadata-from-file startup-script=openstack.sh \
#    --boot-disk-size=300GiB \
#    --boot-disk-type=pd-ssd \
#    --can-ip-forward \
#    --machine-type n1-highcpu-16 \
#    --tags=http-server openstack
#
# gcloud compute routes create openstack-route \
#    --destination-range=172.16.0.0/16 \
#    --next-hop-instance=openstack

export RELEASE=pike

if test -f /etc/debian_version; then
    GITPYTHON=python-git
else
    GITPYTHON=GitPython
fi
export GITPYTHON

curl -Lo boot.sh https://bootstrap.saltstack.com
sh boot.sh -ZDUX -p "$GITPYTHON" stable 2017.7

tee /etc/salt/minion <<HERE
file_client: local
fileserver_backend:
  - git
gitfs_remotes:
  - git://github.com/gtmanfred/devstack-states.git
HERE
tee /etc/salt/grains <<HERE
openstack:
  version: $RELEASE
HERE

salt-call state.apply -l debug 2>&1 | tee /salt.log

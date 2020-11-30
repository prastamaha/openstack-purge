#!/bin/bash

if [[ "$@" == "" ]]; then
echo "Please Insert Args: [path to admin rc] [venv (optional)] "
exit
fi

source $1    # admin-openrc
source $2    # kolla-venv if required

# - Stack

for i in $(openstack stack list -c ID -f value); do
openstack stack delete $i -y
done
echo "[X] Stack"

# - Instance

for i in $(openstack server list -c ID -f value); do
nova force-delete $i
done
echo "[X] Instance"

# - Volume

for i in $(openstack volume list -c ID -f value); do
openstack volume delete $i
done
echo "[X] Volume"

# - Floating IP

for i in $(openstack floating ip list -c ID -f value); do
openstack floating ip delete $i
done
echo "[X] Floating IP"

# - Router Associate Port

for i in $(openstack router list -c ID -f value); do
for j in $(openstack router show $i | grep "port_id" | awk '{print $5}' | sed -e 's/^"//' -e 's/,$//' -e 's/"$//'); do
openstack router remove port $i $j
done
done
echo "[X] Router Interface"

# - Router

for i in $(openstack router list -c ID -f value); do
openstack router delete $i
done
echo "[X] Router"

# - Port

for i in $(openstack port list -c ID -f value); do
openstack port delete $i
done
echo "[X] Port"

# - Subnet

for i in $(openstack subnet list -c ID -f value); do
openstack subnet delete $i
done
echo "[X] Subnet"

# - Network

for i in $(openstack network list -c ID -f value); do
openstack network delete $i
done
echo "[X] Network"

# - Image

for i in $(openstack image list -c ID -f value); do
openstack image delete $i
done
echo "[X] Image"

# - Keypair

for i in $(openstack keypair list -c Name -f value); do
openstack keypair delete $i
done
echo "[X] Keypair"

# - Security group (exclude default)

for i in $(openstack security group list | grep -v 'default' | awk '{print $2}' | grep -v "ID" | sed '/^$/d'); do
openstack security group delete $i
done
echo "[X] Security Group"

# - Flavor

for i in $(openstack flavor list -c ID -f value); do
openstack flavor delete $i
done
echo "[X] Flavor"

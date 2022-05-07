#!/bin/bash

set -e

sed -ci 's/COBBLER_SERVER_IP/'"${COBBLER_SERVER_IP}"'/g' /etc/cobbler/settings.yaml
sed -ci 's/DNSMASQ_DHCP_RANGE1/'"${DNSMASQ_DHCP_RANGE1}"'/g' /etc/cobbler/dnsmasq.template
sed -ci 's/PUPPET_EXITS_FLAG/'"${PUPPET_EXITS_FLAG}"'/g' /usr/local/bin/puppet-ca-sing.sh
sed -ci 's/PUPPET_CA_SERVER/'"${PUPPET_CA_SERVER}"'/g' /usr/local/bin/puppet-ca-sing.sh

/usr/local/bin/cobbler-init-sync.sh &
/usr/local/bin/puppet-ca-sing.sh &

exec /usr/sbin/init

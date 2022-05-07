#!/bin/bash

PUPPET_FLAG=PUPPET_EXITS_FLAG
PUPPET_SERVER=PUPPET_CA_SERVER

if [ "${PUPPET_FLAG}" ]; then
  echo "puppetserver sing"
  timeout -sKILL 30 /opt/puppetlabs/bin/puppet agent --ca_server=${PUPPET_SERVER}
  if [ $? != 0 ]; then 
    echo "ERROR: Could not sing to puppetserver."
    exit 1
  fi
else
  echo "puppetserver no sign"
fi


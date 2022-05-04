#!/bin/bash

set -e

/usr/local/bin/init-sync.sh &

exec /usr/sbin/init

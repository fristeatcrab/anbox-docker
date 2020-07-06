#!/bin/sh
mkdir -p /var/lib/binderfs
mount -t binder binder /var/lib/binderfs > /dev/null 2>&1
exec anbox container-manager "$@"

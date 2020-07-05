#!/bin/sh
mkdir -p /var/lib/binderfs
mount -t binder binder /var/lib/binderfs
exec anbox container-manager "$@"

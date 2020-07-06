#!/bin/bash
systemctl disable --now anbox-container-manager anbox-bridge
rm \
    /usr/local/bin/anbox-bridge.sh \
    /usr/local/bin/anbox-container-manager.sh \
    /etc/systemd/system/anbox-bridge.service \
    /etc/systemd/system/anbox-container-manager.service
systemctl daemon-reload

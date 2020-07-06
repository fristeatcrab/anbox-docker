#!/bin/bash
podman pull msizanoen/anbox:3
cp anbox-container-manager.sh anbox-bridge.sh /usr/local/bin
cp anbox-container-manager.service anbox-bridge.service /etc/systemd/system
systemctl daemon-reload
systemctl enable --now anbox-container-manager anbox-bridge

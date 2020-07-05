#!/bin/bash
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-"/run/user/$(id -u)"}"
export XAUTHORITY="${XAUTHORITY:-"$HOME/.Xauthority"}"
podman run --rm -it \
    --name anbox-container-manager --replace \
    -v /dev/null:/dev/ashmem \
    -v /dev/null:/dev/binder \
    -v /dev/dri:/dev/dri \
    -v /run/anbox-container.socket:/run/anbox-container.socket \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
    -v $XAUTHORITY:$XAUTHORITY \
    --userns=keep-id \
    --env-host \
    --env ANBOX_LOG_LEVEL=debug \
    --privileged \
    msizanoen/anbox:1 \
    anbox session-manager

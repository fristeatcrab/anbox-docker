#!/bin/bash
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-"/run/user/$(id -u)"}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
export XAUTHORITY="${XAUTHORITY:-"$HOME/.Xauthority"}"
if ! (podman ps -a --format "{{.Names}}" | grep '^anbox-session-manager$') ; then
    podman run --rm -dit \
        --name anbox-session-manager \
        --cgroups disabled \
        -v /dev/null:/dev/ashmem \
        -v /dev/null:/dev/binder \
        -v /dev/dri:/dev/dri \
        -v /run/anbox-container.socket:/run/anbox-container.socket \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
        -v $XDG_DATA_HOME:$XDG_DATA_HOME \
        -v $XAUTHORITY:$XAUTHORITY \
        --userns=keep-id \
        --env-host \
        msizanoen/anbox:1 \
        sleep '+Inf'
fi
podman exec -it anbox-session-manager \
    anbox "$@"

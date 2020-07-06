#!/bin/bash
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-"/run/user/$(id -u)"}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
export XAUTHORITY="${XAUTHORITY:-"$HOME/.Xauthority"}"
export ANBOX_DOCKER_LAUNCHER="$(realpath "$0")"
check_exist() {
    podman ps --format "{{.Names}}" | grep "^$cname$"
}
cname=anbox-session-manager
if ! check_exist ; then
    podman run -dit \
        --name $cname --replace \
        -v /dev/null:/dev/ashmem \
        -v /dev/null:/dev/binder \
        -v /dev/dri:/dev/dri \
        -v /run/anbox-container.socket:/run/anbox-container.socket \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
        -v $XDG_DATA_HOME:$XDG_DATA_HOME \
        -v $XAUTHORITY:$XAUTHORITY \
        --userns=keep-id \
        --net=host \
        --ipc=host \
        --env-host \
        $ANBOX_PODMAN_FLAGS \
        msizanoen/anbox:3 \
        anbox session-manager \
        $ANBOX_SESSION_FLAGS > /dev/null
fi
until podman exec -it $cname anbox wait-ready ; do
    if check_exist ; then
        sleep 0.1
    else
        podman logs $cname
        podman rm $cname > /dev/null
        exit 1
    fi
done
exec podman exec -it $cname anbox "$@"

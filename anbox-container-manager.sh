#!/bin/bash
podman run --rm -dit \
    --name anbox-container-manager --replace \
    --privileged \
    --net=host \
    -v /dev:/dev \
    -v /run:/run \
    -v /var/lib/anbox:/var/lib/anbox \
    --env ANBOX_LOG_LEVEL=debug \
    msizanoen/anbox:1 \
    /anbox-container-manager \
    --container-network-dns-servers=1.1.1.1 \
    --android-image=/var/lib/anbox/android.img \
    --data-path=/var/lib/anbox/data \
    --privileged \
    "$@"

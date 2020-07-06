#!/bin/bash
podman run --rm -it \
    --name anbox-container-manager \
    --privileged \
    --net=host \
    -v /dev:/dev \
    -v /run:/run \
    -v /var/lib/anbox:/var/lib/anbox \
    msizanoen/anbox:1 \
    /anbox-container-manager \
    --android-image=/var/lib/anbox/android.img \
    --data-path=/var/lib/anbox/data \
    "$@"

#!/bin/bash
if ! [ -z "$ANBOX_USE_DOCKER" ] ; then
    container_engine=docker
else
    container_engine=podman
fi
$container_engine run --rm -it \
    --name anbox-container-manager \
    --privileged \
    --net=host \
    -v /dev:/dev \
    -v /run:/run \
    -v /var/lib/anbox:/var/lib/anbox \
    msizanoen/anbox:2 \
    /anbox-container-manager \
    --android-image=/var/lib/anbox/android.img \
    --data-path=/var/lib/anbox/data \
    "$@"

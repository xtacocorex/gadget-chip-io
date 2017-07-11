#!/bin/sh

CONTAINER_IMAGE=${CONTAINER_IMAGE:-xtacocorex/gadget-chip-io}

case "$1" in
    build)
        docker build --no-cache=true -t "${CONTAINER_IMAGE}" .
        ;;
    tag)
        docker tag gadget-chip-io xtacocorex/gadget-chip-io
        ;;
    push)
        docker push xtacocorex/gadget-chip-io
        ;;
    all)
        echo "BUILDING"
        docker build --no-cache=true -t "${CONTAINER_IMAGE}" .
        echo "TAGGING"
        docker tag gadget_chip_io xtacocorex/gadget-chip-io
        echo "PUSHING"
        docker push xtacocorex/gadget-chip-io
        ;;
    remove-tags)
        docker rmi `docker images | grep gadget-chip-io | grep "<none>" | tr -s " " | cut -d " " -f 3`
        ;;
esac

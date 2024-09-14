#!/bin/bash

# This command mounts the proper folders to be indexed, and runs a re-index every night.

DIR="$(dirname $(readlink -f $0))"
cd "$DIR"

docker rm -f mlocate

mkdir -p var_lib_mlocate

docker run -d --restart=always --name=mlocate \
   -v /volume1/xps8700/:/volume1/xps8700/:ro \
   -v /volume1/poweredge/:/volume1/poweredge/:ro \
   -v $PWD/var_lib_mlocate:/var/lib/mlocate local/mlocate

sleep 2

docker logs --tail=100 mlocate


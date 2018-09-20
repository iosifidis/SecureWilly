#!/bin/sh

#Build and run docker image
docker build . -t mo

#Version 1 Worked
#docker run --privileged --security-opt "apparmor=mount_profile" -v /home/ubuntu/Security-on-Docker/Docker_tests/mount/simple_example/data:/mount_here -t -i mo:latest

#Version 2
docker run --security-opt "apparmor=mount_profile" -v /home/ubuntu/Security-on-Docker/Docker_tests/mount/simple_example/data:/mount_here -t -i mo:latest

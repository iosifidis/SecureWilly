#!/bin/sh

docker ps | grep attack > dockerps
cut -d' ' -f1 dockerps > containerid
container_id=$(cat containerid)
docker inspect ${container_id} > inspect_output

rm dockerps
rm containerid

cat inspect_output | grep Password

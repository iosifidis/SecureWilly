#!/bin/bash

net=true
#delete network
if $net ; then
	docker network rm docker
fi

service_list=(db app)
for SERVICE in "${service_list[@]}"; do
	docker container rm ${SERVICE} #streaming_dataset
done
	
#docker container rm streaming_server
#docker container rm streaming_client

set -e

# Cleanup
echo "Clean containers"
docker container prune -f

echo "Docker-compose clean volumes"
docker-compose rm -vf

echo "Prune volumes"
docker volume prune -f

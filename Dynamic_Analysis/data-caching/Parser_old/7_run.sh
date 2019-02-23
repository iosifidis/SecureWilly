#!/bin/sh

docker run --name dc-server --net caching_network -d cloudsuite/data-caching:server -t 4 -m 4096 -n 550
docker run -it --name dc-client --net caching_network -v /home/ubuntu/SecureWilly/Dynamic_Analysis/data-caching/scripts:/scripts cloudsuite/data-caching:client ./scripts/clientstask.sh

docker stop dc-server
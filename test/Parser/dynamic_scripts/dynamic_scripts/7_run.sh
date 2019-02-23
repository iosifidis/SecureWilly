#!/bin/bash
 
sudo rm -r /home/ubuntu/SecureWilly/next/data
mkdir /home/ubuntu/SecureWilly/next/data
sudo chown www-data:www-data /home/ubuntu/SecureWilly/next/data

docker-compose up -d
sleep 30

docker exec -u www-data -ti app php occ status > answer
answer=$(cat answer | grep 'Nextcloud is not installed')
while [ -z "$answer" ]
do
rm answer
docker exec -u www-data -ti nextcloud_securewilly php occ status > answer
answer=$(cat answer | grep 'Nextcloud is not installed')
done
rm answer
#Configure nextcloud
docker exec -u www-data -ti app php occ maintenance:install --database "mysql" --database-name "nextcloud" --database-host "db" --database-user "willy" --database-pass "secret" --admin-user "willy" --admin-pass "secret"

#Create a file in local data directory
sudo touch /home/ubuntu/SecureWilly/next/data/willy/files/HelloFromTheOtherSide

#Use occ files:scan to make it visible to the web interface
docker exec -u www-data -ti app php occ files:scan --all

docker kill app
docker kill db

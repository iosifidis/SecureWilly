#!/bin/bash
 
sudo rm -r /home/fani/SecureWilly/Nextcloud/AppArmorOverhead/data
mkdir /home/fani/SecureWilly/Nextcloud/AppArmorOverhead/data
sudo chown www-data:www-data /home/fani/SecureWilly/Nextcloud/AppArmorOverhead/data

docker-compose up -d
sleep 60
docker exec -u www-data nextcloud php occ status > answer
answer=$(cat answer | grep 'Nextcloud is not installed')
while [ -z "$answer" ] && [ ! -z "$error_exec" ]
do
rm answer
docker exec -u www-data nextcloud php occ status > answer 2> error_exec
answer=$(cat answer | grep 'Nextcloud is not installed')
error_exec=$(cat answer | grep 'is not running')
done
rm answer
#Configure nextcloud
docker exec -u www-data nextcloud php occ maintenance:install --database "mysql" --database-name "nextcloud_" --database-host "db" --database-user "willy" --database-pass "secret" --admin-user "willy" --admin-pass "secret"

#Create a file in local data directory
sudo touch /home/fani/SecureWilly/Nextcloud/AppArmorOverhead/data/willy/files/HelloFromTheOtherSide

#Use occ files:scan to make it visible to the web interface
docker exec -u www-data nextcloud php occ files:scan --all

docker kill nextcloud
docker kill db

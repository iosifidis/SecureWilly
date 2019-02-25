#!/bin/bash

#Load the AppArmor profiles for services in the list below
service_list=(cloudsuitedata-servingserver cloudsuitedata-servingclient)
for SERVICE in "${service_list[@]}"; do
	sudo apparmor_parser -r -W /etc/apparmor.d/${SERVICE}_profile
done

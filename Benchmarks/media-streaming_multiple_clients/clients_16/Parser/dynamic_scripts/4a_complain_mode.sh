#!/bin/bash

#Set the profile of each service to complain mode
service_list=(cloudsuitemedia-streamingserver cloudsuitemedia-streamingclient1 cloudsuitemedia-streamingclient2 cloudsuitemedia-streamingclient3 cloudsuitemedia-streamingclient4 cloudsuitemedia-streamingdataset)
for SERVICE in "${service_list[@]}"; do
	sudo aa-complain /etc/apparmor.d/${SERVICE}_profile
done

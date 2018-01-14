#!/bin/bash

for SERVICE in server client dataset; do
#for N in 1 ... ${SERVICES} ; do

	#Capabilities
	#kern logs
	#Find lines that include keyword "capability"
	awk '/capability/ {for(i=1;i<=NF;i++) {if($i ~ /capname/) print $i}}' ../media-streaming/audit_messages/complain_messages/kernlogs_${SERVICE} > tmp_file
	#Strip lines with capability to keep just the capname of each
	awk 'BEGIN {FS="=";} {gsub(/"/,"",$2); print $2;}' tmp_file > awk_out/caps_${SERVICE}

	#dmesg logs
	#Find lines that include keyword "capability"
	awk '/capability/ {for(i=1;i<=NF;i++) {if($i ~ /capname/) print $i}}' ../media-streaming/audit_messages/complain_messages/dmesg_${SERVICE} > tmp_file
	#Strip lines with capability to keep just the capname of each
	awk 'BEGIN {FS="=";} {gsub(/"/,"",$2); print $2;}' tmp_file >> awk_out/caps_${SERVICE}

	#Network
	#kern logs
	#Find lines that include keyword "create" for network - keep family and sock_type
	#Omit protocol, apparmor network rule needs at least 2 parameters
	#awk '/create/ {print $15 ',' $16;}' ../media-streaming/audit_messages/complain_messages/kernlogs_${SERVICE} > tmp_file
	awk '/create/ {for(i=1;i<=NF;i++) {{if($i ~ /family/) printf "%s", $i} {if($i ~ /sock_type/) print "", $i}}}' ../media-streaming/audit_messages/complain_messages/kernlogs_${SERVICE} > tmp_file

	#Strip lines with family and sock_type to keep just the tag of each
	awk 'BEGIN {FS="=| ";} {gsub(/"/,"",$2); gsub(/"/,"",$4); print $2 ',' $4;}' tmp_file > awk_out/net_${SERVICE}

	#dmesg logs
	#Find lines that include keyword "create" for network - keep family and sock_type
	#Omit protocol, apparmor network rule needs at least 2 parameters
#	awk '/create/ {print $10 ',' $11;}' ../media-streaming/audit_messages/complain_messages/dmesg_${SERVICE} > tmp_file
	awk '/create/ {for(i=1;i<=NF;i++) {{if($i ~ /family/) printf "%s", $i} {if($i ~ /sock_type/) print "", $i}}}' ../media-streaming/audit_messages/complain_messages/dmesg_${SERVICE} > tmp_file
	#Strip lines with family and sock_type to keep just the tag of each
	awk 'BEGIN {FS="=| ";} {gsub(/"/,"",$2); gsub(/"/,"",$4); print $2 ',' $4;}' tmp_file >> awk_out/net_${SERVICE}

	rm tmp_file
done


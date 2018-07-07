#!/usr/bin/env python
import io
import sys
from collections import OrderedDict

service = str(sys.argv[1])
new_run = str(sys.argv[2]) #version! The one that exists! (~number here~)
mode = str(sys.argv[3]) #complain, enforce, complain_audit, enforce_audit

old_run = int(version)-1 #round

old_logs = 'Logs/RUN' + old_run + '/awk_out/' + mode + '_logs_file_' + service
new_logs = 'Logs/RUN' + new_run + '/awk_out/' + mode + '_logs_file_' + service

#Open old file logs and new file logs
with open(old_logs,'r') as infile:
    data_1 = infile.readlines()

with open(new_logs,'r') as infile:
        data_2 = infile.readlines()

#Loop for old logs line by line and compare to new logs with every line
for line_f1 in data_1:
    for line_f2 in data_2
        if line_f1 == line_f2:
            #Exact match. Delete line from file 2
        else:
            line_f1 = line_f1.strip('\n')
            line_f1 = line_f1.split('')
            path_f1 = line_f1[0]
            permission_f1 = line_f1[1]
            path_f1 = path_f1.split('/')

            line_f2 = line_f2.strip('\n')
            line_f2 = line_f2.split('')
            path_f2 = line_f2[0]
            permission_f2 = line_f2[1]
            path_f2 = path_f2.split('/')

            len_f1 = len(path_f1)
            len_f2 = len(path_f2)

            if len_f1 == len_f2 :
                if permission_f1 != permission_f2:
                    continue

                #So now maybe we are talking about the same path
                match = []
                i = 0
                num_of_zeros = 0

                for part_f1 in path_f1:
                    if part_f1 == path_f2[i]:
                        #Matching parts -> go to next one
                        match.append('1')
                    else:
                        match.append('0')
                        here_comes_the_instance = i
                        num_of_zeros = num_of_zeros + 1
                    i = i+1

                if num_of_zeros == 0:
                    #Exact match path... This was not supposed to happen

                else if num_of_zeros == 1:
                    #Instance difference. Fix globbing syntax
                    for i in range(0, here_comes_the_instance):
                        new_rule = new_rule.append(path_f1[i] + '/')
                    new_rule[here_comes_the_instance] = '*/'
                    for i in range(here_comes_the_instance+1, len(path_f1)):
                        new_rule = new_rule.append(path_f1[i] + '/')
                    #Add new rule to next profile... (?)
                else:
                    #We are talking about different paths so go on
                    continue

            else
                #Certainly different paths
                continue





new_file_rules = []

#Capability rules
with open(awk_caps,'r') as infile:
    data = infile.readlines()

for line in data:
    line = line.strip('\n')
    new_profile.append('\tcapability ' + line + ',\n')

#Network rules
with open(awk_net,'r') as infile:
    data = infile.readlines()

for line in data:
    line = line.strip('\n')
    new_profile.append('\tnetwork ' + line + ',\n')

#File rules
with open(awk_file,'r') as infile:
    data = infile.readlines()

for line in data:
    if 'requested_mask' in line: #If this is in logs then there is no rule for a certain operation so we omit it
        continue
    line = line.strip('\n')
    line = line.split(' ')
    permission = line[1]
    if 'c' in line[1]: #There is no create permission in apparmor so we change it to write
        if 'w' in line[1]: #if permission is wc we omit c
            permission = line[1].replace("c","")
        else:
            permission = line[1].replace("c","w") #if permission is just c we change it to w
    if line[1] == 'x': #x must follow i,p,c,u so if there is none of these with x we give i permission
        permission = 'ix'
    new_profile.append('\t' + line[0] + ' ' + permission + ',\n')
    new_file_rules.append(line[0] + ' ' + permission + ',\n')

#Signal rules
with open(awk_sgn,'r') as infile:
    data = infile.readlines()

for line in data:
    line = line.strip('\n')
    line = line.split(' ') #Separate in requested_mask, set, peer
    new_profile.append('\tsignal (' + line[0] + ') set=(' + line[1] + ') peer=' + line[2] + ',\n')


#Delete duplicate rules by converting list to set. Convert back to list to keep the order of the beggining and ending of a profile
#This is the way to delete duplicates, when we don't care about the order
new_profile = list(set(new_profile))

#Now there might be some empty lines because of the duplicates missing
#Get rid of them
no_gaps = []
for line in new_profile:
    #Strip whitespace, should leave nothing if empty line was just "\n"
    if 'requested_mask' in line: #If this is in logs then there is no rule for a certain operation so we omit it
        continue
    if not line.strip():
        continue
    #We got something, save it
    else:
        no_gaps.append(line)

#Add the base of the profile in the beginning
#new_profile.insert(0, '#include <tunables/global>\n\nprofile new_profile flags=(attach_disconnected,mediate_deleted) {\n\n')
new_profile = base + no_gaps

#i = 0
#for line in base:
 #   new_profile.insert(i, line)
  #  i=i+1

#End of logs so close the bracket
new_profile.append('}\n')


#Output
with open(new_path, 'w') as outfile:
	outfile.writelines( new_profile )

with open('new_frules_' + service, 'w') as outfile:
    outfile.writelines ( new_file_rules )

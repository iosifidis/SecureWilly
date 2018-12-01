#!/usr/bin/env python

import sys
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

service_list = ["dataset","server","client"]
services = len(service_list)
num_of_runs = sys.argv[services+1]

rules=[] #This will be a 2d list, with services as rows and columns as totals of the rules of the services
rules_services=[]
i=1
for SERVICE in service_list:
    rules_services.append(str(sys.argv[i])) #reading paths of files with totals per run
    rules.append([]) #initiate list of each row
    i+=1

#Create int lists from string arrays
#Reading per line and appending list
i=0
for SERVICE in service_list:
    with open(rules_services[i],'r') as infile:
        data = infile.readlines()
    for line in data:
        line = line.strip('\n')
        line = int(line)
        rules[i].append(line)
    i+=1

#We need the max values of rules of all services for y axis limit
max_rules = []
for i in range(services):
    rules[i] = sorted(rules[i]) #We don't use sort because it returns none, sorted instead returns the sorted list
    max_rules.append(rules[i][int(num_of_runs)-1])
max_value = max(max_rules)

x_Axis=[]
for x in range(int(num_of_runs)):
    x_Axis.append(x)

fig = plt.figure()
ax = fig.add_subplot(111)
ax.plot(x_Axis, rules[0], label="dataset", color="green", marker='x')
ax.plot(x_Axis, rules[1], label="client", color="red", marker='x')
ax.plot(x_Axis, rules[2], label="server", color="blue", marker='x')

ax.legend(loc=0)
ax.grid()
ax.set_xlabel("Runs")
ax.set_ylabel(r"Rules")
ax.set_ylim(0,max_value+2)
plt.show()
plt.title("Rules per run")
plt.savefig("../../parser_output/rules.png",bbox_inches="tight")
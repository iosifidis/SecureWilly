#!/usr/bin/env python2

import io
import sys
from collections import OrderedDict

# This will be the output profile
new_profile = []

service = str(sys.argv[1])
version = str(sys.argv[2]) #New version
mode = 'complain'

new = '../parser_output/profiles/' + service + '/version_' + version

with open(new,'r') as infile:
  data = infile.readlines()

profile = 'profile'
# The parser uses profile name not paths. If paths are used here I have to search for paths noo. Not fixed yet.
# path_to_profile = ''

for line in data:
  if line.startswith(profile):
    new_line = 'profile ' + service + '_profile flags=(audit,attach_disconnected,mediate_deleted) {\n'
    new_profile.append(new_line)
  else:
    new_profile.append(line)

# new_profile.insert(0, '#include <tunables/global>\n\nprofile new_profile flags=(attach_disconnected,mediate_deleted) {\n\n')

# Output
with open(new, 'w') as outfile:
  outfile.writelines( new_profile )

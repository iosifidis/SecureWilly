#!/bin/sh

#Write profile to apparmor
sudo cp ports_2 /etc/apparmor.d
sudo apparmor_parser -r -W /etc/apparmor.d/ports_2

#!/bin/bash 

sudo yum remove ansible -y 
rm -rf /usr/lib/python2.7/site-packages/ansible*
sudo yum install python3 -y
sudo pip3 install --user ansible

#

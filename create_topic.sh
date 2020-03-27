#!/bin/bash
#   script to create a topic

. $HOME/bin/SNS.env

if [ $# -ne 1 ]; then
   echo "Usage: $0 TOPICNAME"
   exit 1
fi

TOPIC=$1
aws sns create-topic --name $TOPIC

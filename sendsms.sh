#!/bin/bash
#   paging using AWS SNS

. $HOME/bin/SNS.env

if [ $# -ne 2 ]; then
   echo "Usage: $0 TopicName Message"
   echo "The Message should be in the double quotes"
   echo "Here is the list of TopicName: "
   echo " "
   aws sns list-topics --output text | awk -F: '{print $6}' | egrep -v 'bounces|compla'
   exit 1
fi


TOPIC=$1
MSG=$2
TMPFILE=/tmp/topics.log

aws sns list-topics --output text > $TMPFILE
cnt=`grep -c $TOPIC $TMPFILE`
if [ $cnt -ne 1 ] ; then
   echo "Invalid TOPIC.  Abort."
   echo "Usage: $0 TopicName Message"
   echo "Here is the list of available TopticName"
   aws sns list-topics --output text | awk -F: '{print $6}' | egrep -v 'bounces|compla'
   exit 1
fi

TOPIC_ARN=`grep $TOPIC /tmp/topics.log | awk '{print $2}'`
aws sns publish --topic-arn "$TOPIC_ARN" --message "From Me:  - $MSG" --subject "MSG: From Me - Do Not Reply"

echo "sent sms to $TOPIC."

#  clean up
rm $TMPFILE

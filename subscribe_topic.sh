#!/bin/bash
#  subscribe_topic.sh

TMPFILE=/tmp/topics.log

. $HOME/bin/SNS.env
aws sns list-topics --output text > $TMPFILE


if [ $# -ne 2 ]; then
   echo "Usage: $0 TOPIC phoneNo"
   echo "Where TOPIC can be ..."
   cat $TMPFILE | while read inrec
   do
      echo $inrec | awk '{print $2}' | awk -F':' '{print "   " $6}'
   done
   exit 1
fi
TOPIC=$1
PHONENO=$2
ENDP="+$PHONENO"

ARN=`grep $TOPIC $TMPFILE | awk '{print $2}'`

echo "Subscribing to $ARN for $ENP ..."
aws sns subscribe --topic-arn $ARN --protocol sms --notification-endpoint "$ENDP" --output=text

# clean up
rm $TMPFILE

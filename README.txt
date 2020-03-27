Update your SNS.env file with a write credential
1.  Create A topic 
    Topic can be a PersonName, a GroupName
  ./create_topic.sh PageFamily
  ./create_topic.sh JohnSmith
2.  Subscribe to a topic
    Subcribe your phone to a topic (groupName, PersonName in #1)
    Phone should all start with 1 for US number
    Phone should not begin with zero for non-US number 
      ./subscribe_topic.sh JohnSmith sms 821219321917
      ./subscribe_topic.sh JohnSmith sms 19259399999
3.  Sending a text (publishing to a topic) 
      sendsms.sh JohnSmith

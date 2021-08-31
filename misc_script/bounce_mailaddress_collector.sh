#!/bin/bash

# From MailAddress 
mail_from="test@example.com"

# Postfix LogFilePlace
maillog_file="/var/log/maillog"

# From to queue_id
queue_id=$(zgrep "from=<$mail_from>" $maillog_file | cut -d" " -f 7| sed -e "s/://" )


# queueid to bounce
while read line
do
    #echo "QueueID : $line"
        zgrep "bounce" $maillog_file | grep $line |grep "to="| cut -d " " -f 8 | sed -e "s/to=<//"|sed -e "s/>//"|sed -e "s/,//"
done <<END
$queue_id
END

# queueid to deffer
while read line
do
    #echo "QueueID : $line"
        zgrep "deffer" $maillog_file | grep $line |grep "to="| cut -d " " -f 8 | sed -e "s/to=<//"|sed -e "s/>//"|sed -e "s/,//"
done <<END
$queue_id
END

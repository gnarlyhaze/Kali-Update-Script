#!/bin/bash
# Created by Nathan Clifford
# This program uses text-to-speech utilities to read my school schedule each morning.
# I use crontab to schedule this script to run at a certain time each morning. 

sudo apt-get -y install flite #installs flite text-to-speech software
sudo apt-get install -y fortune-mod #installs MOTD software

flite -voice slt -t "Good Morning Nathan!" #hardcode your own name here
#whoami | flite -voice slt #use the system username instead of hardcoding name
flite -voice slt -t "Today's date is"
date +"%A%B%d" | flite -voice slt #day of week and month

now=$(date +"%I:%M%p")
echo "The time is $now" | flite -voice slt #current time

# On weekends report that there are no classes to attend.
day=$(date +"%A")
if [ $day == "Saturday" ] || [ $day == "Sunday" ]; then flite -voice slt -t "You don't have any classes today."
fi

# On weekdays report that there are classes to attend.
if [ $day == "Monday" ] || [ $day == "Tuesday" ] || [ $day == "Wednesday" ] || [ $day == "Thursday" ] || [ $day == "Friday" ]; then flite -voice slt -t "You have classes today."
fi

# On weekdays report which classes there are to attend.
if [ $day == "Monday" ]; then flite -voice slt -t "You have an Info Management and Cryptography lab at 12AM till 3PM. The bus to Fleming arrives at 11:40 AM. You have a Criminal Procedures class at 5PM till 8PM. The bus to Fleming arrives at 4:20PM"
fi
if [ $day == "Tuesday" ]; then flite -voice slt -t "You have a Scaling Networks class at 10AM till 11AM. The bus to Fleming arrives at 9:40 AM."
fi
if [ $day == "Wednesday" ]; then flite -voice slt -t "You have a Pentesting lab at 10AM till 1PM. The bus to Fleming arrives at 9:40 AM."
fi
if [ $day == "Thursday" ]; then flite -voice slt -t "You have a Digital Investigations lab at 8AM till 11AM. The bus to Fleming arrives at 7:40 AM. You have a Scaling Networks class at 12PM till 1PM. You have a Scaling Networks lab at 2PM till 5PM."
fi
if [ $day == "Friday" ]; then flite -voice slt -t "You have a Scaling Networks lab at 11AM till 2PM. The bus to Fleming arrives at 10:20 AM."
fi

# Message of the day (MOTD)
echo "Your message for today is" | flite -voice slt
fortune | flite -voice slt
exit

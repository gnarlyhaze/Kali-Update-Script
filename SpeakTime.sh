#!/bin/bash
# This program uses text-to-speech utilities to say the current time.
# I use crontab to schedule this script to run each hour.

#sudo apt-get -y install espeak #installs espeak text-to-speech software
sudo apt-get -y install flite #installs flite text-to-speech software

#date +%I:%M%p | espeak
date +%I:%M%p | flite -voice slt

# Slightly different formatting
#if [ $(date +%M) != "00" ]; then date +%-H:%M%p%Z; else echo -n $(date +%-H); echo -n "oh clock "; date +%p; date +%Z; fi | espeak -ven+f6
 

#!/bin/bash
#Will show your public facing IP Address
echo "WAN IP Address is:"
dig +short myip.opendns.com @resolver1.opendns.com

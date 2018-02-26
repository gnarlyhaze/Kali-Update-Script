#!/bin/bash
# This program will tell you the current cpu temperature.
# Use the watch command with this script to received regularly updated reports of the system temperature.
# ie. watch ./cpu_temperature.sh

cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))

#gpuTemp0=$(/opt/vc/bin/vcgencmd measure_temp) #this formatting doesn't seem to work in Kali
#gpuTemp0=${gpuTemp0//\'/º}
#gpuTemp0=${gpuTemp0//temp=/}

echo CPU Temp: $cpuTemp1"."$cpuTempM"ºC"
#echo GPU Temp: $gpuTemp0 #this doesn't work in Kali
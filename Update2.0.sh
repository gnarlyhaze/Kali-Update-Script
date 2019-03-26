#!/bin/bash
# Created by Nathan Clifford for OSCP Coursework

# Description:
# This script is for updating, and performing basic configurations on Linux
# distros that use apt as the package manager (ie. Kali, Debian, Raspbian, Ubuntu).
# This means that if you're using a different package manager such as yum or zypper (ie. RedHat, Fedora, OpenSuse)
# then this script will probably not work on your OS.

# Script Usage Instructions:
# Copy this file to a location on your system (ie. ~/Desktop), ensuring that the file extension is .sh
# cd ~/Desktop
# chmod u+x Update.sh
# sudo ./Update.sh

### Correct errors from any previously failed installations (leave enabled):
sudo apt --fix-broken install -y
sudo dpkg --configure -a

# Correct "The following signatures were invalid" EXPKEYSIG error upon trying to run updates (This will occur if you haven't updated your Kali ISO for awhile):
#wget -q -O - archive.kali.org/archive-key.asc | apt-key add

# Remove packages left in an "inconsistent state" (incompatible packages which fail to completely install):
#sudo dpkg --remove --force-remove-reinstreq --force-depends <package-name>
#sudo apt-get install -f --reinstall <package-name> #reinstall inconsistent state packages.

#Show distribution information:
sudo apt -qq install -y screenfetch linuxlogo #used to generate one of those nifty terminal theme information + ASCII distribution logos
echo ""
screenfetch #ascii art system info
#echo ""
#linuxlogo #more ascii art system info

# Current version info
echo ""
printf "${LGREEN}Current version info...${NC}\n"
lsb_release -irdc
printf "Kernal Version: ";uname -r
printf "Processor Type: ";uname -m

# Assign text colour for alert lines:  
RED='\033[0;31m' # Red
GREEN='\033[0;32m' # Green
LGREEN='\033[1;32m' # Light Green 
NC='\033[0m' # No Color
#change {TEXTCOLOR} to {RED}, {GREEN}, or {LGREEN} to change text colour.

# Change system hostname:
#sudo nano /etc/hostname
#sudo nano /etc/hosts
#sudo reboot

# Add user account with sudo privileges:
#adduser gnarlyhaze sudo

### Install ntpdate internet time and sync time to server (leave enabled):
echo ""
printf "${LGREEN}Syncing System Clock to Internet Time...${NC}\n"
sudo apt -qq install -y ntpdate
sudo ntpdate -u ntp.ubuntu.com
update-rc.d ntp enable # Ensure ntp service runs at bootup
#sudo ntpdate time.nist.gov #different time server
#dpkg-reconfigure tzdata #manually configure timezone

### Perform System Updates (leave enabled, these are the primary actions of this script):
echo ""
printf "${LGREEN}Performing System Updates - This may take some time...${NC}\n"
sudo apt clean
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y 

### Install Aptitude & Synaptic, and update Aptitude packages (leave enabled):
echo ""
printf "${LGREEN}Installing/Updating Aptitude & Synaptic Package Managers...${NC}\n"
sudo apt install -y synaptic # Synaptic package manager
sudo apt install -y  aptitude #Aptitude package manager
sudo aptitude update #update packages in Aptitude
sudo aptitude upgrade -y --full-resolver #upgrade packages in Aptitude

### Install & Run Unattended Upgrades - automatic installation of security upgrades (leave enabled):
echo ""
printf "${LGREEN}Installing Security Upgrades...${NC}\n"
sudo apt install -y unattended-upgrades
sudo unattended-upgrades

#Kali Linux recommended installs:
echo ""
printf "${LGREEN}Installing Kali Linux Recommended Installs...${NC}\n"
sudo apt install -y open-vm-tools-desktop fuse #VMware tools - https://docs.kali.org/general-use/install-vmware-tools-kali-guest
sudo apt install -y  kali-linux-top10 #Install the top ten Kali Linux Utilities
#sudo apt install -y kali-linux-full #full Kali Linux software suite #3GB

#Install Wireshark Application:
echo ""
printf "${LGREEN}Installing Wireshark...${NC}\n"
sudo apt install -y wireshark wireshark-gtk wireshark-qt # Wireshark
sudo apt install -y tcpdump #command line packet analyzer
#sudo dpkg-reconfigure wireshark-common #fix wireshark permission denied errors
#sudo adduser $USER wireshark

##Information Gathering/Scanner Utilities:
echo ""
printf "${LGREEN}Installing Scanning Utilities...${NC}\n"
sudo apt install -y nmap netcat ncat # network exploration tool to perform security audits
#sudo apt install -y 0trace # security reconnaissance/firewall bypassing tool
#sudo apt install -y masscan #fast port scanner
#sudo apt install -y firewalk #traceroute through firewall and find open ports
#sudo apt install -y p0f #OS fingerprinting tool

##Kali Linux - Bruteforcing Utilities:
#echo ""
#printf "${LGREEN}Bruteforcing Utilities...${NC}\n"
#sudo apt install -y  john # JohnTheRipper -fast password cracker
#sudo apt install -y cewl #Custom Wordlist Generator allows you to create your own custom dictionary file.
#sudo apt install -y goldendict 
#sudo apt install -y rarcrack #untested

###Kali Linux - Anonymizing Utilities:
#sudo apt install -y squid3 #Squid Proxy
#sudo apt install -y macchanger #recommended to hide your MAC address while cracking a foreign wireless network.
#sudo apt install -y proxychains #tunnel kali commands thru proxy server. Hides source IP.

###VPN
#sudo apt install -y openvpn #vpn framework
#sudo apt install -y network-manager-openvpn
#sudo apt install -y network-manager-openvpn-gnome
#sudo apt install -y network-manager-pptp
#sudo apt install -y network-manager-pptp-gnome
#sudo apt install -y network-manager-strongswan
#sudo apt install -y network-manager-vpnc
#sudo apt install -y network-manager-vpnc-gnome

##Kali Linux - Vulnerability Analysis Utilities:
sudo apt install -y nikto #web server testing tool

#Install & Setup Armitage and Metasploit Framework:
echo ""
printf "${LGREEN}Installing Armitage and Metasploit...${NC}\n"
sudo apt install -y metasploit-framework # Metasploit Framework
sudo apt install -y  armitage #Armitage GUI for Metasploit Framework
#sudo gem install bundler #fix armitage dependencies
#sudo gem update #fix armitage dependencies

# Update Metasploit Framework:
service postgresql start && msfdb init
msfdb start && msfdb stop
#msfupdate
apt update; apt install metasploit-framework #preferred update syntax

##Audio Utilities for Kali Linux (Kali's audio often doesn't work without these):
echo ""
printf "${LGREEN}Installing Audio Utilities...${NC}\n"
sudo apt install -y alsa-utils #fix sound mute on Kali Linux on boot
sudo apt install -y  alsa-tools alsa-tools-gui alsa-oss alsamixergui libalsaplayer0 #audio player files
sudo apt install -y kmix #audio files
#sudo apt install -y  mpg321 #command line mp3 player

### Install NVIDIA Graphic Card Drivers:
echo ""
printf "${LGREEN}Installing NVIDIA Graphic Card Drivers...${NC}\n"
sudo apt install -y ocl-icd-libopencl1 nvidia-driver nvidia-cuda-toolkit

### Install Python and update PIP (it appears the system default is Python 2.7, change this to v3 at your own risk):
###DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
echo ""
printf "${LGREEN}Installing Python2 & Updating PIP...${NC}\n"
### Install Python 2:
sudo apt install -y python-pip python-dev 
sudo apt install -y software-properties-common
sudo pip install virtualenv
#Upgrade PIP
pip install --upgrade pip

###Install SSH client & server
echo ""
printf "${LGREEN}Configuring SSH client & server...${NC}\n"
sudo apt install -y ssh #install and enable sshd
sudo apt install -y putty #gui ssh client
#sudo apt install -y openssh-server
#sudo apt install -y openssh-client

###SSH Setup
echo ""
printf "${LGREEN}Generating new SSH keys & starting SSH on boot...${NC}\n"
cd /etc/ssh/ && mkdir default_kali_keys && mv ssh_host_* default_kali_keys/ #Move default SSH keys
dpkg-reconfigure openssh-server && service ssh restart #Generate new SSH keys
service ssh start && update-rc.d -f ssh remove && update-rc.d ssh defaults #start SSH service after reboot by modifying run level settings

#Add SSH Warning Banner before SSH login
#nano /etc/issue.net #write your warning message in this file ie. "Authorized access only!"
#nano /etc/ssh/sshd_config #open sshd_config file
#uncomment "Banner /etc/issue.net"
#service ssh restart

### Set an SSH Welcome Banner after login - Message of the Day (MOTD)
#nano /etc/motd ##write your warning message in this file ie. "Welcome back to your system!"

### VNC client & server applications
#echo ""
#printf "${LGREEN}Installing VNC client & server applications...${NC}\n"
#sudo apt install -y autocutsel #allows copy and paste text between applications
#sudo apt install -y x11vnc #Simple VNC Server
#x11vnc -storepasswd # Assign a VNC password for x11vnc
#sudo apt install -y tightvncserver #TightVNC -Kali's default VNC Server
#sudo apt install -y tightvncclient #TightVNC Client
#sudo apt install -y remmina # Similar to Windows Remote Desktop functions
#sudo apt install -y vmfs-tools #untested

### Install Terminal applications, notification applications
# update-alternatives --config x-terminal-emulator #set a default terminal emulator program
echo ""
printf "${LGREEN}Installing Terminal applications and Alternate Shells...${NC}\n"
sudo apt install -y terminator # My favorite Terminal emulator
mkdir /root/.config/terminator
sudo apt install -y asciinema #Records terminal sessions and sharing them on the web, start with "asciinema rec" 
sudo apt install -y bash-completion #a set of bash scripts to enable customized completion for specific commands
#sudo apt install -y lxterminal # Another solid Terminal emulator
#sudo apt install -y  guake #Drop down terminal emulator used with F12 - Also a favorite
#sudo apt install  yakuake #Light-weight drop down terminal emulator used with F12
#sudo apt install -y undistract-me #notifications that watch for long running commands and create a popup when complete

### Install Alternate Terminal Shells
sudo apt install -y fish # the friendly interactive shell (fish)
sudo apt install -y zsh #An extended Bourne shell
#sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" #Install oh-my-zsh add-on for zsh (run-once)

#printf "${LGREEN}Changing Terminal shell - use "chsh -s bash" or "exec bash" to change back...${NC}\n"
#exec zsh #syntax to temporarily switch terminal shell (ie. to zsh, bash, sh, or fish)
#chsh -s $(which fish) #change default shell to fish
#chsh -s $(which zsh) #change default shell to zsh
sudo chsh -s /bin/bash #change default shell back to BASH

### Install Utility applications
echo ""
printf "${LGREEN}Installing Utility applications...${NC}\n"
sudo apt install -y gparted #gparted disk utility
sudo apt install -y speedtest-cli #speedtest from command line
sudo apt install -y gdebi #GUI for installing .deb files
sudo apt install -y ipcalc #calculate IP information for a host
sudo apt install -y sysvinit-utils
sudo apt install -y gnome-tweak-tool #OS option editor
sudo apt install -y alacarte #Applications menu customization options
sudo apt install -y git git-core #github commandline
sudo apt install -y ca-certificates # resolve issue where GitHub's SSL certificate isn't trusted
sudo apt install -y unrar rar unace p7zip zip unzip p7zip-full p7zip-rar file-roller
#sudo apt install -y orage #Calendar

### Install Text Editors:
echo ""
printf "${LGREEN}Installing Text Editors...${NC}\n"
sudo apt install -y geany # My favorite light text editor
sudo apt install -y leafpad # Basic text editor
#sudo apt install -y mousepad #xfce text editor

### Install Office applications:
echo ""
printf "${LGREEN}Installing Office applications...${NC}\n"
sudo apt install -y libreoffice libreoffice-gnome # LibreOffice Suite
#sudo apt install -y evince #PDF Viewer
#sudo apt install -y kjots knotes #Notes program
#sudo apt install -y openoffice # OpenOffice Suite
#sudo apt install -y abiword #GNOME word document processor

### Media players applications, and graphics/video editing applications:
echo ""
printf "${LGREEN}Installing Media applications...${NC}\n"
sudo apt install -y clementine #Media player
sudo apt install -y vlc #VLC Player

#Screenshot Tools
echo ""
printf "${LGREEN}Installing Screenshot Tools...${NC}\n"
sudo apt install -y gnome-screenshot
sudo apt install -y scrot
sudo apt install -y imagemagick
#sudo apt install -y shutter
#sudo apt install -y gtk-recordmydesktop recordmydesktop #Screen recorder software

# Webcam applications:
#echo ""
#printf "${LGREEN}Installing Webcam applications...${NC}\n"
#sudo apt install -y at-spi2-core
#sudo apt install -y cheese #Webcam utility
#sudo apt install -y v4l-utils
#sudo modprobe bcm2835-v4l2 #Load webcam driver

# Text-To-Speech modules:
#echo ""
#printf "${LGREEN}Installing Text-To-Speech Modules...${NC}\n"
#sudo apt install -y espeak
#sudo apt install -y flite
#sudo apt install -y festival

# Amusing Programs & Linux Games:
echo ""
printf "${LGREEN}Installing Linux Games & Amusing Programs...${NC}\n"
sudo apt install -y fortunes-min #minimum fortunes
#sudo apt install -y xcowsay cowsay #this is an important package -needs to be configured in Kali
#sudo apt install -y sl #terminal steam locamotive

#Clean-up unused packages (leave enabled):
echo ""
printf "${LGREEN}Cleaning Up...${NC}\n"
sudo apt autoclean -y
sudo apt autoremove -y

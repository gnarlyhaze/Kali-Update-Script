#!/bin/bash
# Created by Nathan Clifford
# This script opens a terminal titled with the current username name at the top.

#sudo apt install -y terminator #installs terminator if you don't already have it.
#sudo apt install -y lxterminal #installs lxterminal if you don't already have it.

# Pass username to terminal title as a variable.
#USER=Nathan #Hard-code your name instead of using whoami command to discover the current username.
USER=$(whoami)

# Open a terminal with the current username as the title.
terminator --working-directory=~/Desktop --title="$USER's Shell" 
#lxterminal --working-directory=~/Desktop --title="$USER's Shell" 

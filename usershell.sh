#!/bin/bash
# Created by Nathan Clifford
# This script opens a terminal window titled with the current username with the ~/Desktop of the directory.

# Pass username to terminal title as a variable.
#USER=Nathan #Hard-code your own name here instead of using the whoami command to discover the current username (which in Kali is probably just root)
USER=$(whoami)

# Open a terminal with the current username as the title.
x-terminal-emulator --working-directory=~/Desktop --title="$USER's Shell" 

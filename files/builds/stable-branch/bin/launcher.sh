#!/bin/bash

#############################################################################
# Name:         Autodesk Fusion 360 - Launcher (Linux)                      #
# Description:  With this file you run Autodesk Fusion 360 on your system.  #
# Author:       Steve Zabka                                                 #
# Author URI:   https://cryinkfly.com                                       #
# License:      MIT                                                         #
# Copyright (c) 2020-2022                                                   #
# Time/Date:    12:00/21.02.2022                                            #
# Version:      1.4                                                         #
#############################################################################

# Path: /$HOME/.config/fusion-360/bin/launcher.sh

#################################
# Open Autodesk Fusion 360 now! #
#################################

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# This feature will check if there is a new version of Autodesk Fusion 360.
function setupact-check-fusion360 {
  wget -N -P $HOME/.config/fusion-360/bin https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/update-config.txt  
}

function setupact-config-update {
  config_update=`. $HOME/.config/fusion-360/bin/read-text.sh $HOME/.config/fusion-360/bin/update-config.txt 1`
  if [ "$config_update" = "Update=1" ]; then
    # A value of 0 means that there is no update and a value of 1 will notify the user that there is an update.
    get_update=1
  else
    echo "Do nothing!"
    get_update=0
  fi 
}

###############################################################################################################################################################

# You must change the first part ($HOME/.wineprefixes/fusion360) and the last part (WINEPREFIX="$HOME/.wineprefixes/fusion360") when you have installed Autodesk Fusion 360 into another directory!
function setupact-open-fusion360 {
  launcher="$(find $HOME/.wineprefixes/fusion360 -name Fusion360.exe -printf "%T+ %p\n" | sort -r 2>&1 | head -n 1 | sed -r 's/.+0000000000 (.+)/\1/')" && WINEPREFIX="$HOME/.wineprefixes/fusion360" wine "$launcher"
}

###############################################################################################################################################################
# THE PROGRAM IS STARTED HERE:                                                                                                                                #
###############################################################################################################################################################

setupact-check-fusion360
setupact-config-update
# This path you must change if you installed a custom installation of Autodesk Fusion 360! For example: $HOME/.config/fusion-360/bin/update-usb.sh 
. $HOME/.config/fusion-360/bin/update.sh 
setupact-open-fusion360

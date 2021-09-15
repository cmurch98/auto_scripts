#!/bin/bash
echo -e "Welcome to setup_bashrc.sh!\nThis script will add some pre-defined aliases and modify some default .bashrc parameters." | fold -s

echo "Inserting aliases..."
sed -ri "/#alias l='ls -CF'/a alias fu='sudo apt -qq update && sudo apt -qq upgrade -y'" /home/pi/.bashrc
echo "Alias 'fu' (Full Upgrade) Complete"
echo "Done!"

echo "Updating bash history duplicates..."
sed -i "s/HISTCONTROL=ignoreboth/HISTCONTROL=erasedups/" /home/pi/.bashrc
echo "Done!"

echo "Re-sourcing the .bashrc file..."
source /home/pi/.bashrc
echo "Done!"

echo -e "----------------------------------------\nsetup_bashrc.sh complete!\n"

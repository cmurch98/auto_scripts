#!/bin/bash

echo -e "Welcome to setup_venv.sh\nThis script will install and configure the Python3 venv package."

# Navigate to the home directory for no particular reason
cd
# Update and upgrade
sudo apt update && sudo apt upgrade -y
# Install Python3
sudo apt install python3 -y
# Install PIP
sudo apt install python3-pip
# Install venv
sudo apt install python3-venv

# Ask the user if they would like to create a venv
echo "Would you like to create a venv now? [y/n]"
# Read the user response
read response

# String compare
if [ $response = "y" ]
then
	# Query venv name
	echo "What would you like to name the venv?"
	# Read name
	read venv_title
	# Create the venv
	python3 -m venv $venv_title

	echo "Enter the venv using the following command 'source ./$venv_title/bin/activate'"

fi

echo "In a venv, install packages using 'python -m pip install PACKAGE'"
echo "Thanks for using setup_venv.sh"

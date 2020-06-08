#!/bin/bash
echo -e "Welcome to setup_venv.sh\nThis script will install and configure the Python3 venv package."

# Define variables
regex_yes="[Yy]"

# Navigate to the home directory for no particular reason
cd
# Update and upgrade
sudo apt update && sudo apt upgrade -y
# Install Python3
sudo apt install python3 -y
# Install PIP
sudo apt install python3-pip -y
# Install venv
sudo apt install python3-venv -y

# Ask the user if they would like to create a venv
echo "Would you like to create a venv now? [y/n]"
# Read the user response
read response

# String compare
if [[ $response =~ regex_yes ]]
then
	# Query venv name
	echo "What would you like to name the venv?"
	# Read name
	read venv_title
	# Create the venv
	python3 -m venv $venv_title

	echo -e "To enter the venv, use the following command:\n\tsource ./$venv_title/bin/activate"

fi

echo -e "To create another venv, deactivate any environments in use and call the following command:\n\tpython3 -m venv VENV"
echo -e "To install python packages in the venv, use the following command:\n\tpython -m pip install PACKAGE"
echo -e "----------------------------------------\nVENV seup "

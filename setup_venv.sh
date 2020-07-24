#!/bin/bash
echo -e "Welcome to setup_venv.sh\nThis script will install and configure the Python3 venv package." | fold -s

# Define variables
regex_yes="[Yy]"

# Navigate to the home directory for no particular reason
cd

# Quietly check for updates and upgrade
echo -e "\nChecking for system updates..."
sudo apt -qq update
echo "Updating system..."
sudo apt -qq upgrade -y

# Quietly fetch the latest Python3, pip and venv modules
echo -e "\nFetching the latest Python3, pip and venv modules..." | fold -s
sudo apt -qq install python3 -y
sudo apt -qq install python3-pip -y
sudo apt -qq install python3-venv -y

# Ask the user if they would like to create a venv
echo -e "\nWould you like to create a venv now? [y/n]" | fold -s 
# Read the user response
read response

# String compare
if [[ $response =~ $regex_yes ]]
then
	# Query venv name
	echo "What would you like to name the venv?" | fold -s
	# Read name
	read venv_title
	# Create the venv
	python3 -m venv $venv_title

	echo -e "To enter the venv, use the following command:\n\tsource ./$venv_title/bin/activate" | fold -s

fi

echo -e "\nTo create another venv, deactivate any environments in use and call the following command:\n\n\tpython3 -m venv VENV\n" | fold -s
echo -e "To install python packages in the venv, use the following command:\n\n\tpython -m pip install PACKAGE\n" | fold -s
echo -e "Thanks for using setup_venv.sh"

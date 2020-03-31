#!/bin/bash

echo -e "Welcome to setup_ssh.sh!\nThis script will setup ssh keys and modify some default ssh parameters."

# Navigate to the home directory and delete the existing .ssh directory
cd && rm .ssh -rf
# Make a new .ssh directory and set rwx permissions for the user
mkdir .ssh && chmod 700 .ssh
# Navigate to the new .ssh directory, create an empty authorized_keys file and assign rwx permissions for the user
cd .ssh && touch authorized_keys && chmod 700 authorized_keys

echo "Generating Public/Private Key Pair"

# Generate an ssh key pair with no password authentication
echo | ssh-keygen -P ''

# Ask the user for a port number
echo "Which port would you like to enable for SSH?"

# Read the port specification from the user
read port

# If the port selected is not the default
if [ $port -ne 22 ]
then

	# Define a string for each setting
	newPort="Port $port"
	pubkeyAuth="PubkeyAuthentication Yes"
	passwordAuth="PasswordAuthentication No"

	echo "Replacing default SSH rules"

	# Replace the relevant lines in the sshd_config
	sudo sed -i "s/#Port 22/$newPort/" /etc/ssh/sshd_config
	sudo sed -i "s/#PubkeyAuthentication yes/$pubkeyAuth/" /etc/ssh/sshd_config
	sudo sed -i "s/#PasswordAuthentication yes/$passwordAuth/" /etc/ssh/sshd_config

else
	echo "Port remains unchanged"
fi

echo "Completed! Remember to copy across the putty key"

# Change back to the home directory and list its contents
cd && ls -al

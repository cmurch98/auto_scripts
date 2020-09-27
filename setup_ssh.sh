#!/bin/bash
echo -e "Welcome to setup_ssh.sh!\nThis script will setup SSH keys and modify some default ssh parameters."

# Define variables and constants
passwordAuth="PasswordAuthentication No"
pubkeyAuth="PubkeyAuthentication Yes"
regex_int="^[0-9]+$"
unset port

# Navigate to the home directory and delete the existing .ssh directory
cd && rm .ssh -rf
# Make a new .ssh directory and set rwx permissions for the user (owner)
mkdir .ssh && chmod 700 .ssh
# Navigate to the new .ssh directory, create an empty authorized_keys file and assign rwx permissions for the user (owner)
cd .ssh && touch authorized_keys && chmod 700 authorized_keys

# Generate an ssh key pair with no password authentication
echo -n "Generating Public/Private Key Pair... "
echo | ssh-keygen -P ''
echo "Done!"

# Error checking loop
while ! [[ $port =~ $regex_int ]]
do
	# Ask the user for a port number and record the answer
	read -p "Which port should be used for SSH connections: " port

	# If the number is not an integer
	if ! [[ $port =~ $re ]] || [ $port -ge 65536 ]
	then
		# Print that the port is invalid and unset the port variable
		echo "Invalid Port No. Please try again"
		unset port
	fi
done

# Modify the port variable
newPort="Port $port"

# Replace the relevant lines in the sshd_config
echo "Replacing default SSH rules..."
sudo sed -i "s/#Port 22/$newPort/" /etc/ssh/sshd_config
sudo sed -i "s/#PubkeyAuthentication yes/$pubkeyAuth/" /etc/ssh/sshd_config
sudo sed -i "s/#PasswordAuthentication yes/$passwordAuth/" /etc/ssh/sshd_config
echo "Done!"

# Direct the stdout of the public key file into the authorized_keys file 
echo "Copying in putty key..."
cat /home/pi/auto_scripts/putty_key >> authorized_keys
echo "Done!"

echo "Restarting the SSH service"
sudo systemctl restart ssh
echo "Done!"

echo -e "----------------------------------------\nSSH setup complete!\n"
# Change back to the home directory and list its contents
cd && ls -al

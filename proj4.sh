# User Management

#!/bin/bash

# Ensure the script is executed with sudo or root access
if [[ "${UID}" -ne 0 ]]
then
    echo 'Please run with sudo or root.'
    exit 1
fi

# Check if at least one argument is provided
if [[ "${#}" -lt 1 ]]
then
    echo "Usage: ${0} USER_NAME [COMMENT...]"
    echo 'Create a user with USER_NAME and an optional COMMENT.'
    exit 1
fi

# Store the first argument as the username
USER_NAME="${1}"
echo "Creating user: $USER_NAME"

# Shift to get the rest of the arguments as the account comments
shift
COMMENT="${@}"

# Generate a password
PASSWORD=$(date +%s%N )

# Create the user with the provided comment and home directory
useradd -c "${COMMENT}" -m "${USER_NAME}"

# Check if the user was successfully created
if [[ $? -ne 0 ]]
then
    echo "The account could not be created."
    exit 1
fi

# Set the password for the user
echo $PASSWORD | passwd --stdin $USER_NAME

# Check if the password was successfully set
if [[ $? -ne 0 ]]
then
    echo "The password could not be set."
    exit 1
fi

# Force password change on first login
passwd -e "${USER_NAME}"

# Display the username, password, and the host where the user was created
echo
echo "Username: ${USER_NAME}"
echo "Password: ${PASSWORD}"
echo "Hostname: $(hostname)"


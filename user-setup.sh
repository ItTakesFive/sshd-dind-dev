#!/bin/bash -e

USERNAME="$1"

help() {
cat<<EOF
Usage: $0 username [ssh port]
EOF
}

if [ -z "$USERNAME" ]; then
  help
  exit 1
fi

echo "Create User: $USERNAME"

if [ -e "/home/$USERNAME" ]; then 
  useradd -s /bin/zsh $USERNAME
else
  useradd -m -s /bin/zsh $USERNAME
fi

echo "Setup $USERNAME password"
passwd "$USERNAME"

echo "Setup sudo"
usermod -aG sudo "$USERNAME"

echo "Setup docker"
usermod -aG root "$USERNAME"

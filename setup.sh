#!/bin/bash -e

USERNAME="$1"
PORT=8022

help() {
cat<<EOF
Usage: $0 username [ssh port]
EOF
}

if [ -z "$USERNAME" ]; then
  help
  exit 1
fi

if [ -n "$2" ]; then
  if [[ "$2" =~ [0-9]+ ]] && [ $2 -gt 0 -a $2 -lt 65536 ]; then 
    PORT=$2
  else
    help
    exit 1
  fi
fi

echo "Compile Docker Image"
docker build -t sshd-dind-dev .

echo "Create Docker Container and listening $PORT port for SSH"
docker run -d --privileged \
         --name sshd-dind-dev \
         -p $PORT:22 \
         -v //var/run/docker.sock:/var/run/docker.sock sshd-dind-dev

echo "Setup user: $USERNAME"
docker exec -it sshd-dind-dev /user-setup.sh "$USERNAME"

echo "ssh -p $PORT $USERNAME@localhost"
ssh -p $PORT $USERNAME@localhost

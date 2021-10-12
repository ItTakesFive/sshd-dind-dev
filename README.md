# SSH and Docker-in-Docker

```sh
# Compile Docker Image
docker build -t sshd-dind-dev .

# Create Docker Container and listening 8022 port for SSH
docker run -d --privileged \
         --name sshd-dind-dev \
         -p 8022:22 \
         -v //var/run/docker.sock:/var/run/docker.sock sshd-dind-dev

# Execute
docker exec -it sshd-dind-dev docker ps

# Create User
docker exec -it sshd-dind-dev useradd -s /bin/zsh user

# Setup password
docker exec -it sshd-dind-dev passwd user 

# Setup sudo 
docker exec -it sshd-dind-dev usermod -aG sudo user

# Setup docker
docker exec -it sshd-dind-dev usermod -aG root user

# SSH
ssh -p 8022 user@localhost
```

or 

```sh
./setup.sh user 8022
```

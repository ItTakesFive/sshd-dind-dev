FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TERM xterm-256color

RUN apt-get update && apt-get install -y \
        sudo \
        tmux \
        zsh \
        httpie \
        git \
        vim \
        wget \
        curl \
        silversearcher-ag

RUN apt-get update && apt-get install openssh-server -y

RUN mkdir /var/run/sshd
RUN ssh-keygen -A

# Docker
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# Locales
RUN apt-get install -y locales && \
      dpkg-reconfigure locales && \
      locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8 \
      LC_ALL=en_US.UTF-8

EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

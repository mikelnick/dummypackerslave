FROM ubuntu:16.04

RUN mkdir /var/run/sshd

RUN useradd -ms /bin/bash dockerslave
RUN echo "dockerslave:dockerslave" | chpasswd

RUN apt-get update && \
    apt-get -y install wget git unzip openjdk-8-jre openssh-server

RUN cd /var && \
    wget https://releases.hashicorp.com/packer/0.12.1/packer_0.12.1_linux_amd64.zip && \
    unzip packer_0.12.1_linux_amd64.zip

COPY packerpath.sh /etc/profile.d/packerpath.sh
RUN chmod +x /etc/profile.d/packerpath.sh

EXPOSE 22

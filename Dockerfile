FROM ubuntu:16.04

RUN mkdir /var/run/sshd /var/packer

RUN useradd -ms /bin/bash dockerslave
RUN echo "dockerslave:dockerslave" | chpasswd

RUN apt-get update && \
    apt-get -y install wget git unzip openjdk-8-jre openssh-server

RUN cd /var/packer && \
    wget https://releases.hashicorp.com/packer/0.12.1/packer_0.12.1_linux_amd64.zip && \
    unzip packer_0.12.1_linux_amd64.zip

RUN chown -R dockerslave /var/packer

RUN echo 'export PATH=/usr/packer:$PATH' >>/home/dockerslave/.profile

ENV PATH /var/packer:$PATH

EXPOSE 22

USER dockerslave

FROM ubuntu:16.04

RUN useradd -ms /bin/bash dockerslave
RUN echo "dockerslave:dockerslave" | chpasswd

RUN mkdir /var/run/sshd /var/packer /home/dockerslave/.ssh

RUN apt-get update && \
    apt-get -y install wget git unzip openjdk-8-jre openssh-server

RUN cd /var/packer && \
    wget https://releases.hashicorp.com/packer/0.12.1/packer_0.12.1_linux_amd64.zip && \
    unzip packer_0.12.1_linux_amd64.zip

RUN touch /home/dockerslave/.ssh/known_hosts

RUN ssh-keyscan -p 22 github.com/lvtech >> /home/dockerslave/.ssh/known_hosts

RUN echo 'export PATH=/usr/packer:$PATH' >>/home/dockerslave/.profile

RUN echo 'export PATH=/usr/packer:$PATH' >>~/.bash_profile

RUN echo 'export PATH=/usr/packer:$PATH' >>/etc/environment

ENV PATH /var/packer:$PATH

EXPOSE 22

USER root
CMD ["/usr/sbin/sshd", "-D"]
FROM ubuntu:16.04

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

RUN mkdir /var/run/sshd
RUN adduser --quiet jenkins
RUN echo "jenkins:jenkins" | chpasswd

USER jenkins
RUN mkdir /var/packer /home/jenkins/.ssh

RUN apt-get update && \
    apt-get -y install wget git unzip openjdk-8-jre openssh-server

RUN cd /var/packer && \
    wget https://releases.hashicorp.com/packer/0.12.1/packer_0.12.1_linux_amd64.zip && \
    unzip packer_0.12.1_linux_amd64.zip

RUN touch /home/jenkins/.ssh/known_hosts

RUN ssh-keyscan github.com/lvtech >> /home/jenkins/.ssh/known_hosts

EXPOSE 22

USER root

ENV PATH /var/packer:$PATH

CMD ["/usr/sbin/sshd", "-D"]
FROM debian:wheezy
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install packages
RUN apt-get update && \
    apt-get -y install openssh-server pwgen && \
    mkdir -p /var/run/sshd && \
    sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update && apt-get -y install vim oracle-java7-installer
RUN apt-get install -y oracle-java7-set-default curl xmlstarlet bsdtar unzip

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**

EXPOSE 22
CMD ["/run.sh"]

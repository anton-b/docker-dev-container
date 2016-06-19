FROM centos:6.8
MAINTAINER Anton Benkevich

ENV sys_user anton
ENV sys_user_password passw0rd
ENV git_user Anton Benkevich
ENV git_email anton.benkevich@gmail.com

## Add additional software repos
RUN yum install -y epel-release
RUN yum install -y centos-release-SCL

## Install system tools
RUN yum install openssh-server openssh-client -y
RUN yum install bash-completion sudo -y

## Install dev tools
RUN yum install gcc automake autoconf git -y
RUN rpm -if http://www.rabbitmq.com/releases/erlang/erlang-18.3-1.el6.x86_64.rpm

##Configure steps

## git initial config

RUN git config --global user.name "${git_user}"
RUN git config --global user.email ${git_email}

## User setup
RUN groupadd sudo
RUN useradd ${sys_user} -g sudo
RUN echo ${sys_user}:password | chpasswd
RUN echo '%sudo    ALL=(ALL)       ALL' >> /etc/sudoers

## Install ssh identity
COPY files/dot_ssh/* /home/${sys_user}/.ssh/

## Install monitoring
RUN yum install monit -y
COPY files/sshd.conf /etc/monit.d
COPY files/monit.conf /etc/monit.conf
RUN chmod -R 700 /etc/monit.*

## Run
RUN /etc/init.d/sshd start
CMD ["/usr/bin/monit", "-I"]
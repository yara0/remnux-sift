#
# This Docker image contains the latest version of REMnux and SIFT toolkits on Ubuntu 20.04 (focal).
# REMnux®, created by Lenny Zeltser, is a toolkit for reverse-engineering and analyzing malware.
# SIFT, created by Rob Lee, is a toolkit for investigating memory, network, registry, and file system.
# This image combines the toolkits together to help forensics investigators use them in one place.
#

FROM ubuntu:20.04

LABEL description="REMnux & SIFT forensics toolkits combined in one place for analyzing and investigating malware, file system, registry, memory, and network"
LABEL maintainer="Yara Altehini (@yara0, https://github.com/yara0)"

USER root

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y wget gnupg git && \
    wget -nv -O - https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg | apt-key add - && \
    echo "deb [arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" > /etc/apt/sources.list.d/saltstack.list && \
    apt-get update && \
    apt-get install -y salt-common && \
    git clone https://github.com/REMnux/salt-states.git /srv/salt && \
    salt-call -l info --local state.sls remnux.cloud pillar='{"remnux_user": "remnux-sift"}' && \
    curl -Lo /usr/local/bin/sift https://github.com/sans-dfir/sift-cli/releases/download/v1.11.0/sift-cli-linux && \
    chmod +x /usr/local/bin/sift

USER remnux-sift

RUN sudo sift install --mode=packages-only --user=remnux-sift && \
    sudo rm -rf /srv && \
    sudo rm -rf /var/cache/salt/* && \
    sudo rm -rf /root/.cache/*

USER root

ENV TERM linux
WORKDIR /home/remnux-sift
EXPOSE 9999

RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

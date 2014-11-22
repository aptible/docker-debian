FROM debian:wheezy
MAINTAINER Frank Macreery <frank@macreery.com>

ONBUILD RUN apt-get update
RUN apt-get update

# Install Git
RUN apt-get install -y git

# Add custom .bashrc
ADD files/bashrc /root/.bashrc

# Install Bats
RUN git clone https://github.com/sstephenson/bats.git /tmp/bats && \
    cd /tmp/bats && ./install.sh /usr/local

# Integration tests
ADD test /tmp/test
RUN bats /tmp/test

CMD /bin/bash
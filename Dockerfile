ARG TAG
FROM --platform=linux/x86_64 debian:${TAG}
# Add custom files
# TODO: Figure out why `ADD files /` creates a huge layer
ADD files/root/bashrc /root/.bashrc
ADD files/usr/bin/apt-install /usr/bin/apt-install

# Install latest security updates now, and on build
# During build, we use a different CDN to allow fixing DSA 4371-1.
ARG VERSION
RUN export VERSION=${VERSION}

RUN SECURITY_LIST=$(mktemp) \
 && if [ "$VERSION" = 'stretch' ] || [ "$VERSION" = 'buster' ]; then export NAME="$VERSION"; else export NAME="$VERSION-security"; fi \
 && if [ "$VERSION" = 'stretch' ]; then echo "deb http://archive.debian.org/debian-security $NAME/updates main" > $SECURITY_LIST; else echo "deb http://security-cdn.debian.org/debian-security $NAME/updates main" > $SECURITY_LIST; fi \
 && apt-get -o "Dir::Etc::SourceList=$SECURITY_LIST" -o Acquire::http::AllowRedirect=false update \
 && apt-get -o "Dir::Etc::SourceList=$SECURITY_LIST" -o Acquire::http::AllowRedirect=false upgrade -y \
 && rm -rf /var/lib/apt/lists/* \
 && rm $SECURITY_LIST

# This follows: https://stackoverflow.com/a/76094521 as stretch updates have been moved/removed from
# the original links
RUN if [ "$VERSION" == 'stretch' ]; then \
    sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list; fi

# Changing this as bookworm doesn't have anything at /etc/apt/sources.list
ONBUILD RUN if [ "$VERSION" != 'bookworm' ]; then \
 SECURITY_LIST=$(mktemp) \
 && grep security /etc/apt/sources.list > $SECURITY_LIST \
 && apt-get -o "Dir::Etc::SourceList=$SECURITY_LIST" update \
 && apt-get -o "Dir::Etc::SourceList=$SECURITY_LIST" upgrade -y \
 && rm -rf /var/lib/apt/lists/* \
 && rm $SECURITY_LIST; fi

# Install wget
RUN apt-install wget ca-certificates tzdata

# Install Bats
RUN wget https://github.com/sstephenson/bats/archive/v0.4.0.tar.gz && \
    tar xzf v0.4.0.tar.gz && cd bats-0.4.0 && ./install.sh /usr/local && \
    cd .. && rm -rf v0.4.0.tar.gz bats-0.4.0

# Integration tests
ADD test /tmp/test
RUN bats /tmp/test

CMD /bin/bash

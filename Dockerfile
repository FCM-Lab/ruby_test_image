FROM arm64v8/ruby:2.5.7
MAINTAINER Guillermo Guerrero 'guillermo.guerrero@fr.fcm.travel'

ENV OPENSSL_CONF=/etc/ssl
ENV PHANTOM_JS=phantomjs-2.1.1-linux-x86_64

RUN apt-get update && apt-get install -y wget python-pip less groff
RUN pip install awscli==1.18.35

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN wget --quiet -O - /tmp/pubkey.gpg  https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list

# RUN apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
RUN apt-get update -qq && apt-get install -y build-essential default-libmysqlclient-dev libsnappy-dev libpq-dev cron libicu-dev git yarn nodejs postgresql-client-12

RUN wget https://github.com/Medium/phantomjs/releases/download/v2.1.1/$PHANTOM_JS.tar.bz2
RUN tar xvjf $PHANTOM_JS.tar.bz2
RUN mv $PHANTOM_JS /usr/local/share
RUN ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

# install chromium
RUN apt-get update -y && \
  wget http://security.debian.org/debian-security/pool/updates/main/c/chromium/chromium_89.0.4389.114-1~deb10u1_arm64.deb && \
  dpkg -i chromium_89.0.4389.114-1~deb10u1_arm64.deb; apt-get -fy install
RUN cp /usr/bin/chromium /usr/bin/chrome

RUN wget http://ftp.debian.org/debian/pool/main/c/chromium/chromium-driver_89.0.4389.114-1~deb10u1_arm64.deb && \
    dpkg -i chromium-driver_89.0.4389.114-1~deb10u1_arm64.deb; apt-get -fy install

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
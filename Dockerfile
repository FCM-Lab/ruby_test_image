FROM ruby:2.6.6
MAINTAINER Guillermo Guerrero 'guillermo.guerrero@fr.fcm.travel'

ENV OPENSSL_CONF=/etc/ssl
ENV PHANTOM_JS=phantomjs-2.1.1-linux-x86_64

RUN apt-get update && apt-get install -y wget python-pip less groff
RUN pip install awscli==1.18.35

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential default-libmysqlclient-dev libsnappy-dev libpq-dev cron libicu-dev git yarn nodejs postgresql-client

RUN wget https://github.com/Medium/phantomjs/releases/download/v2.1.1/$PHANTOM_JS.tar.bz2
RUN tar xvjf $PHANTOM_JS.tar.bz2
RUN mv $PHANTOM_JS /usr/local/share
RUN ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

# install chrome
RUN apt-get update -y && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

# install chromedriver and place it in the path
RUN wget https://chromedriver.storage.googleapis.com/2.38/chromedriver_linux64.zip && \
  unzip chromedriver_linux64.zip && \
  mv chromedriver /usr/local/bin/

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

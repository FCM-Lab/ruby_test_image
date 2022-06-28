FROM ruby:3.0.4
MAINTAINER Guillermo Guerrero 'guillermo.guerrero@fr.fcm.travel'

ENV OPENSSL_CONF=/etc/ssl

RUN apt-get update && apt-get install -y wget less groff gnupg

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN wget --quiet -O - /tmp/pubkey.gpg  https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential default-libmysqlclient-dev libsnappy-dev libpq-dev cron libicu-dev git yarn nodejs postgresql-client mongodb-mongosh

# install chrome
RUN apt-get update -y && \
  wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_91.0.4472.114-1_amd64.deb && \
  dpkg -i google-chrome-stable_91.0.4472.114-1_amd64.deb; apt-get -fy install

# install chromedriver and place it in the path
RUN wget https://chromedriver.storage.googleapis.com/91.0.4472.19/chromedriver_linux64.zip && \
  unzip chromedriver_linux64.zip && \
  mv chromedriver /usr/local/bin/

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

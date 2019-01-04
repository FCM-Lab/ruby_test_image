FROM ruby:2.1.3
MAINTAINER Guillermo Guerrero 'guillermo.guerrero@fr.fcm.travel'

ENV PHANTOM_JS=phantomjs-1.9.8-linux-x86_64

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential libmysqlclient-dev libmysqld-dev libsnappy-dev libpq-dev cron libicu-dev git yarn nodejs postgresql-client xvfb wkhtmltopdf wget
RUN gem install bundler -v 1.9.9

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
RUN tar xvjf $PHANTOM_JS.tar.bz2
RUN mv $PHANTOM_JS /usr/local/share
RUN ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

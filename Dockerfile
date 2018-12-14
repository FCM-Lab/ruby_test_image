FROM ruby:2.3.1
MAINTAINER Guillermo Guerrero 'guillermo.guerrero@fr.fcm.travel'

RUN apt-get update && apt-get install wget
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# 14.04 repo
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" >> /etc/apt/sources.list.d/postgresql.list

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential libmysqld-dev libsnappy-dev libpq-dev cron libicu-dev git yarn nodejs postgresql-client-9.5

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

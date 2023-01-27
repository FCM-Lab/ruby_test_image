FROM ruby:3.1.2
MAINTAINER Guillermo Guerrero 'guillermo.guerrero@fr.fcm.travel'

ENV OPENSSL_CONF=/etc/ssl

RUN apt-get update && apt-get install -y wget less groff gnupg

# mongo client
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list


RUN apt-get update -qq && apt-get install -y build-essential libsnappy-dev libpq-dev cron libicu-dev git

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

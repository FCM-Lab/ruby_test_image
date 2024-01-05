FROM ruby:3.3.0
LABEL maintainer="FCM LAB developer@fr.fcm.travel"

RUN apt-get update && apt-get install -y wget python-pip less groff

# RUN apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
RUN apt-get update -qq && apt-get install -y build-essential libsnappy-dev libpq-dev cron libicu-dev git postgresql-client

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

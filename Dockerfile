FROM ruby:3.1.2-buster
LABEL maintainer="FCM LAB developer@fr.fcm.travel"

RUN apt-get update && apt-get install -y wget python-pip less groff
RUN pip install awscli==1.18.35

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list

# RUN apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
RUN apt-get update -qq && apt-get install -y build-essential default-libmysqlclient-dev libsnappy-dev libpq-dev cron libicu-dev git yarn nodejs postgresql-client-12

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

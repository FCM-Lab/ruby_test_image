FROM ruby:3.1.2
MAINTAINER Guillermo Guerrero 'guillermo.guerrero@fr.fcm.travel'
ENV RAILS_ENV=production \
    RACK_ENV=production \
    APP_HOME=/ruby-app \
    LANG="C.UTF-8"
    
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
VOLUME $APP_HOME/log

# Install node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev yarn nodejs curl imagemagick git cron

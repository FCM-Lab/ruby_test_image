FROM ruby:3.1.2
# Install node
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
# Install packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs curl imagemagick git cron postgresql-client
RUN npm install -g npm@8.19.2
RUN npm i -g yarn


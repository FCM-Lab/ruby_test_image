FROM ruby:3.2.3-bullseye

ENV OPENSSL_CONF=/etc/ssl

RUN apt-get update && apt-get install -y wget less groff gnupg

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN wget --quiet -O - /tmp/pubkey.gpg  https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb https://apt.postgresql.org/pub/repos/apt bullseye-pgdg main 16" | tee /etc/apt/sources.list.d/pgdg.list

RUN apt-get update -qq && apt-get install -y build-essential libsnappy-dev libpq-dev cron libicu-dev git yarn nodejs postgresql-client

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
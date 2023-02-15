FROM ruby:3.1.2

ENV OPENSSL_CONF=/etc/ssl
ENV PHANTOM_JS=phantomjs-2.1.1-linux-x86_64

RUN apt-get update -y
RUN apt-get install -y wget python3 python3-pip less groff \
  gnupg2 wget ca-certificates lsb-release software-properties-common
RUN pip install awscli==1.18.35

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor > yarnkey.gpg
RUN install -o root -g root -m 644 yarnkey.gpg /etc/apt/trusted.gpg.d/
RUN rm yarnkey.gpg

RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install node
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list

#RUN apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
RUN apt-get update -qq && apt-get install -y build-essential default-libmysqlclient-dev libsnappy-dev libpq-dev cron libicu-dev git yarn postgresql-client-12

# install chrome
RUN apt-get update -y && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

# install chromedriver and place it in the path
RUN apt-get install chromium-driver -y
RUN mv /usr/bin/chromedriver /usr/local/bin/chromedriver

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

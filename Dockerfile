FROM ruby:3.1.2

ENV OPENSSL_CONF=/etc/ssl
ENV PHANTOM_JS=phantomjs-2.1.1-linux-x86_64

RUN apt-get update -y
RUN apt-get install -y wget python3 python3-pip less groff
RUN pip install awscli==1.18.35

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list

RUN apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
RUN apt-get update -qq && apt-get install -y build-essential default-libmysqlclient-dev libsnappy-dev libpq-dev cron libicu-dev git yarn nodejs postgresql-client-12

RUN wget https://github.com/Medium/phantomjs/releases/download/v2.1.1/$PHANTOM_JS.tar.bz2
RUN tar xvjf $PHANTOM_JS.tar.bz2
RUN mv $PHANTOM_JS /usr/local/share
RUN ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

# install chrome
RUN apt-get update -y && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

# install chromedriver and place it in the path
RUN apt-get install chromium-driver -y
RUN mv /usr/bin/chromedriver /usr/local/bin/chromedriver

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM ruby:3.0.4-buster

RUN apt-get update && apt-get install -y wget python-pip less groff
RUN pip install awscli==1.18.35

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list

# RUN apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
RUN apt-get update -qq && apt-get install -y build-essential default-libmysqlclient-dev libsnappy-dev libpq-dev cron libicu-dev git yarn nodejs postgresql-client-12

ADD john_ssh_keys /root/.ssh
RUN chmod -R 700 /root/.ssh && chmod 744 /root/.ssh/id_rsa.pub

# install chrome
RUN apt-get update -y && \
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

# install chromedriver and place it in the path
RUN wget https://chromedriver.storage.googleapis.com/2.38/chromedriver_linux64.zip && \
  unzip chromedriver_linux64.zip && \
  mv chromedriver /usr/local/bin/

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
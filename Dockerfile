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
ADD john_ssh_keys /root/.ssh
RUN chmod -R 700 /root/.ssh && chmod 744 /root/.ssh/id_rsa.pub
ADD package.json yarn.lock $APP_HOME/
RUN yarn install
ADD Gemfile Gemfile.lock $APP_HOME/
RUN bundle install --jobs 20 --retry 5 --deployment --without test development
ADD . $APP_HOME/

# Precompile Rails assets
RUN bundle exec rake assets:precompile
RUN bundle exec rails g fcm_tools:kafka_patch
EXPOSE 3000
CMD bundle exec rails s
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

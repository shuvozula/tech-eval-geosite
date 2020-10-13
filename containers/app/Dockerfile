FROM ruby:2.6.5-slim

RUN apt-get update && \
    apt-get install -y curl apt-transport-https gnupg2 build-essential libcurl4-openssl-dev libxml2-dev libsqlite3-dev libpq-dev nodejs sqlite3 --no-install-recommends

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y --no-install-recommends yarn

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

ENV APP_PATH /usr/src/app

RUN mkdir -p $APP_PATH

COPY Gemfile $APP_PATH
COPY Gemfile.lock $APP_PATH

WORKDIR $APP_PATH

RUN bundle install

COPY . $APP_PATH

ENV RAILS_ENV development

RUN yarn install --check-files

RUN bin/rake db:migrate

ENV LANDSAT_URL https://landsat-pds.s3.amazonaws.com/
RUN bin/rake db:seed
RUN bin/rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
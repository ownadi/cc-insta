FROM ruby:2.4-slim
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs libpq-dev wget libfontconfig imagemagick
ENV PHANTOMJS_VERSION 2.1.1
RUN wget --no-check-certificate -q -O - https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 | tar xjC /opt
RUN ln -s /opt/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/bin/phantomjs
ENV INSTALL_PATH /cc_insta
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs
COPY . .
RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname ACTION_CABLE_ALLOWED_REQUEST_ORIGINS=foo,bar SECRET_TOKEN=dummytoken assets:precompile
# VOLUME ["$INSTALL_PATH/public"]
CMD puma -C config/puma.rb

FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql postgresql-contrib
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install --retry 5 --without development test
ADD . /myapp
ENV RAILS_ENV production
ENV RACK_ENV production
RUN bundle exec rake assets:precompile

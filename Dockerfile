FROM ruby:2.4.1-stretch

COPY . /usr/src/maestroapp
WORKDIR /usr/src/maestroapp
RUN bundle install


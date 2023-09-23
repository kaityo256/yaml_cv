FROM ruby:3.1-slim

RUN apt-get update && apt-get install -y git make
WORKDIR /tmp
COPY Gemfile Gemfile.lock /tmp/
RUN bundle install

FROM ruby:2.7.0-alpine

COPY Gemfile* /app/

WORKDIR /app
ARG BUNDLER_OPTIONS

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --update --no-cache \
      make \
      imagemagick \
      mariadb-connector-c \
      tzdata \
      less \
      git \
      build-base \
      ncurses && \
    apk add --update --no-cache --virtual=build-dependencies \
      mariadb-dev && \
    bundle install -j4 ${BUNDLER_OPTIONS} && \
    apk del build-dependencies

COPY . /app

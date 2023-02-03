FROM ruby:2.7.1-alpine

ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql git imagemagick" \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    ROOT_DIR=/var/www

RUN  mkdir $ROOT_DIR

WORKDIR $ROOT_DIR

COPY backend/Gemfile* ./

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    gem update --system && \
    gem install bundler && \
    bundle config set force_ruby_platform true && \
    bundle install -j4 && \
    apk del build-dependencies 

COPY . .

FROM ruby:2.7.1

ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

RUN  mkdir /var/www

WORKDIR /var/www

COPY Gemfile* /var/www

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  libpq-dev \
  sudo \
  nginx && \
  gem install bundler

RUN bundle install

ADD . /var/www

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids

RUN groupadd nginx
RUN useradd -g nginx nginx
ADD nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

RUN chmod +x /var/www/entrypoint.sh

CMD ["/var/www/entrypoint.sh"]

#!/bin/sh

sudo service nginx start
cd /var/www
bin/setup
bundle exec rails db:seed RAILS_ENV=production
bundle exec pumactl start

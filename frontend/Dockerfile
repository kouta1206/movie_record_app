FROM node:16-alpine

WORKDIR /var/www

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV HOST 0.0.0.0

ADD package.json /var/www/package.json
ADD package-lock.json /var/www/package-lock.json

RUN npm install \
        npm install create-nuxt-app

ADD . /var/www

RUN npm run build

EXPOSE 3000

CMD ["npm", "run", "start"]


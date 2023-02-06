FROM node:16-alpine

ARG WORKDIR
ARG CONTAINER_PORT
ARG API_URL
ARG API_URL_BROWSER

ENV HOME=${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0 \
    API_URL=${API_URL} \
    API_URL_BROWSER=${API_URL_BROWSER}

WORKDIR ${HOME}

COPY package*.json ./
RUN yarn install
COPY /frontend/ ./
RUN yarn run build

EXPOSE ${CONTAINER_PORT}

FROM docker.io/node:14.14.0-alpine

WORKDIR /app

RUN apk add postgresql-dev python-dev build-base

RUN apk add --no-cache --virtual .build \
  g++ git make python

COPY package*.json ./

# TODO get `npm ci` to work
RUN npm install
RUN apk del .build

COPY . .

RUN npm run build

CMD npm run serve

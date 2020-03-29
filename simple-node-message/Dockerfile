FROM node:alpine

WORKDIR /app

COPY ./package*.json ./

RUN npm ci

COPY ./index.js ./index.js

CMD ["node", "index.js"]
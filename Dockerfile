FROM node:4-onbuild

EXPOSE 7000

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install
COPY ./public /usr/src/app
COPY ./router /usr/src/app
COPY ./ums.js /usr/src/app
COPY ./views /usr/src/app

CMD ["node", "ums.js"]


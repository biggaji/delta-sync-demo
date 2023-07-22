FROM node:18.17.0-alpine as build
WORKDIR /syncer
COPY package*.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build

FROM build as staging
COPY --from=build node_modules /syncer/node_modules
EXPOSE $PORT
CMD [ "node", "index.js" ]

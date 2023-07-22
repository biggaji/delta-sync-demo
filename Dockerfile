FROM node:18.17.0-alpine as build
WORKDIR /syncer
COPY package*.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build

FROM node:18.17.0-alpine as production
ENV NODE_ENV production
WORKDIR /syncer
COPY package*.json yarn.lock ./
RUN yarn install --production
COPY --from=build /syncer/dist ./dist
CMD [ "node", "./dist/index.js" ]
EXPOSE 81

FROM production as staging
ENV NODE_ENV staging
EXPOSE 4000
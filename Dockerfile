FROM node:12-alpine AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY ./src ./src
RUN npm build

FROM node:12-alpine
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY --from=build /usr/src/app/src ./src
EXPOSE 3050
CMD ["node", "./src/app.js"]

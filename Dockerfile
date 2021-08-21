FROM node:12 AS build
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY ./src ./src
RUN npm run build

FROM node:12-alpine
WORKDIR /src
COPY package.json ./
RUN npm install
COPY --from=build /usr/src/app/ ./
EXPOSE 3540
CMD ["npm", "run"]

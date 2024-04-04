# Stage 1: Build the React app
FROM node:alpine as builder

WORKDIR /app

COPY package*.json yarn.lock ./
RUN yarn install
RUN yarn global add vite && yarn add axios


COPY . .

RUN yarn run build

# Stage 2: Serve the built app using a lightweight web server
FROM node:alpine

WORKDIR /app

COPY --from=builder /app/dist ./dist

RUN yarn global add serve

EXPOSE 80

CMD serve -s dist -l 80
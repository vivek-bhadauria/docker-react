# Multi step build example
# Step 1. Make an image for "npm run build"
# Step 2. Copy the result of "npm run build" to nginx and start nginx

#Step 1 : Making an image for "npm run build"
FROM alpine as builder

WORKDIR /usr/app

RUN apk add --update nodejs npm
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /usr/app/build /usr/share/nginx/html

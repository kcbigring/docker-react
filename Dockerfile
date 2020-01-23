# build phase
FROM node:alpine as builder

WORKDIR '/var/www/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# run phase (terminates previous block)
FROM nginx
# copy build folder from previous phase (that's all we want)
COPY --from=builder /var/www/app/build /usr/share/nginx/html

# default nginx container starts up by itslef
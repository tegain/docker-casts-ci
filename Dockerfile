# Need to create a multi-phases Dockerfile
# because we need 2 base images: Node & Nginx

# Multiple phases using `AS`
FROM node:alpine AS builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Using a new `FROM` statement starts a new phase,
# so no need for `AS` here
FROM nginx
EXPOSE 80

# Need custom nginx configuration?
# COPY nginx.conf /etc/nginx/nginx.conf

# See https://hub.docker.com/_/nginx
# `--from=` copies from another phase
COPY --from=builder /app/build /usr/share/nginx/html



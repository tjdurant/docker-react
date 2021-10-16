# Build phase block
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
CMD npm run build

# All of this is to install dependencies
# and run npm run build, the output of which will
# be in the /app/build folder. That folder is all we need!

# Run phase block
FROM nginx
# EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# default command for nginx is to start nginx. so, no CMD needed
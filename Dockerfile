#create builder phase
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run phase
FROM nginx
# with current AWS, we dont need to expose port for EBS
# it will look for a docker.compose.yml file to build from by default instead of a Dockerfile.
# EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
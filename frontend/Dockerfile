# Use a Node image
FROM node:23.4.0 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 5173
RUN npm run build
# CMD ["npm", "run", "build"]

FROM nginx:1.27.3
EXPOSE 3000
COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf
COPY --from=builder /app/build /usr/share/nginx/html

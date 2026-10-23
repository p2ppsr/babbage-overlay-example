FROM node:22.23.4-alpine
RUN apk add --no-cache nginx bash && \
    install -d -o nginx -g nginx /var/lib/nginx /run/nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080
WORKDIR /app
ENV PATH="/app/node_modules/.bin:${PATH}"
COPY package.json package-lock.json ./
RUN npm ci --include=optional
COPY . .
RUN npm run build
CMD [ "sh", "scripts/start.sh"]

FROM node:22-alpine

WORKDIR /app

COPY package.json server.js ./
RUN mkdir -p public
COPY index.html public/index.html

EXPOSE 8080

USER node

CMD ["node", "server.js"]

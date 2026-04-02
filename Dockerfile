ARG BASE_IMAGE=node:22-slim

FROM ${BASE_IMAGE}

WORKDIR /app

# Copy server and application
COPY server.js /app/server.js
RUN mkdir -p /app/public
COPY index.html /app/public/index.html

# Run as non-root user
USER node

EXPOSE 8080

CMD ["node", "server.js"]

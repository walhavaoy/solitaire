FROM nginx:alpine

# Configure nginx for non-root execution (platform runs as UID 1000)
RUN sed -i 's/^user/#user/' /etc/nginx/nginx.conf && \
    sed -i '/^pid/c\pid /tmp/nginx.pid;' /etc/nginx/nginx.conf && \
    chown -R nginx:nginx /var/cache/nginx && \
    chmod -R 755 /var/cache/nginx

# Use /tmp for nginx temp directories (writable by non-root)
RUN sed -i 's|client_body_temp_path /var/cache/nginx/client_temp|client_body_temp_path /tmp/client_temp|' /etc/nginx/nginx.conf || true

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html

RUN chown -R nginx:nginx /usr/share/nginx/html

EXPOSE 8080
USER nginx

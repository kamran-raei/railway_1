FROM nginx:alpine

RUN rm -rf /docker-entrypoint.d/* && \
    printf 'events {}\n\
http {\n\
    server {\n\
        listen 80;\n\
\n\
        location / {\n\
            proxy_pass https://ray.darkns.ir;\n\
\n\
            proxy_http_version 1.1;\n\
            proxy_set_header Upgrade $http_upgrade;\n\
            proxy_set_header Connection "upgrade";\n\
\n\
            proxy_set_header Host ray.darkns.ir;\n\
            proxy_set_header X-Real-IP $remote_addr;\n\
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n\
            proxy_set_header X-Forwarded-Proto https;\n\
\n\
            proxy_ssl_server_name on;\n\
            proxy_ssl_name ray.darkns.ir;\n\
            proxy_ssl_verify off;\n\
\n\
            proxy_read_timeout 86400;\n\
            proxy_send_timeout 86400;\n\
        }\n\
    }\n\
}\n' > /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
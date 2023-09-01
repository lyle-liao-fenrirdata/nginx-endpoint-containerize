FROM nginx:latest

RUN mkdir -p /etc/nginx/ssl/

# 在容器中生成自簽SSL憑証
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt -subj "/C=TW/ST=Taipei/L=Taipei/O=Organization/CN=localhost"

# 複製NGINX配置文件到容器中
# COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Remove any existing config files
RUN rm /etc/nginx/conf.d/*

# *.conf files in conf.d/ dir get included in main config
COPY ./nginx.conf /etc/nginx/conf.d/

# Expose the listening port
EXPOSE 80
EXPOSE 443

# Launch NGINX
CMD [ "nginx", "-g", "daemon off;" ]

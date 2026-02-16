FROM nginx:mainline-alpine AS product-stage

COPY ./nginx_prod.conf /etc/nginx/nginx.conf
COPY ./default_prod.conf /etc/nginx/conf.d/default.conf
COPY ./uwsgi_params /etc/nginx/uwsgi_params

USER root

RUN chown -R nginx:0 /var/cache/nginx
RUN chmod -R g+w /var/cache/nginx

RUN mkdir -p /vol/web/static
RUN mkdir -p /vol/web/media
RUN chown -R nginx:0 /vol/web
RUN chmod -R 755 /vol/web

COPY ./entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER nginx
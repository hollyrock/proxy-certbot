FROM nginx:mainline-alpine AS product-stage 

COPY ./nginx_prod.conf /etc/nginx/nginx.conf
COPY ./default_prod.conf /etc/nginx/conf.d/default.conf
COPY ./uwsgi_params /etc/nginx/uwsgi_params

USER root

RUN chown -R nginx:0 /var/cache/nginx
RUN chmod -R g+w /var/cache/nginx

RUN mkdir -p /vol/static
RUN mkdir -p /vol/media
RUN chmod 755 /vol/static
RUN chmod 755 /vol/media

USER nginx
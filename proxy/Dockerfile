FROM nginx:alpine

RUN rm /etc/nginx/conf.d/*
COPY ./certificate/* /etc/nginx/certificates/
COPY ./main-domain.conf ./gitlab.conf /etc/nginx/conf.d/
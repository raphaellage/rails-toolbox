FROM nginx:latest
COPY docker/nginx/reverse-proxy.conf /etc/nginx/conf.d/reverse-proxy.conf
EXPOSE 8020
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
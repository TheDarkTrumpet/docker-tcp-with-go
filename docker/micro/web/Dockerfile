FROM nginx:latest

COPY artifacts/dist /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx" ]
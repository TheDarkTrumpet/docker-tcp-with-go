FROM nginx:latest

COPY start.sh /src/
COPY artifacts/client /src/
COPY artifacts/server /src/
COPY artifacts/dist /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /src/start.sh

CMD /src/start.sh

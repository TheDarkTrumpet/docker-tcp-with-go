FROM nginx:latest

COPY start.sh /src/
COPY ../../client/build/client /src/
COPY ../../server/build/server /src/
COPY ../../server/frontend/dist /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /src/start.sh

CMD /src/start.sh

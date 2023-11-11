FROM ubuntu:22.04 
#update package lists and install necessary packages
RUN apt-get update
RUN apt-get install -y nginx zip curl
#disable daemon mode for Nginx
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i '/^daemon/!b;:a;n;/^$/!ba;i daemon off;' /etc/nginx/nginx.conf
#Download and unzip the 2048 game from GtitHub
RUN curl -o /var/www/html/master.zip -L https://codeload.github.com/gabrielecirulli/2048/zip/master
RUN cd /var/www/html/ && unzip master.zip && mv 2048-master/* . && rm -rf 2048-master master.zip
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
#CMD ["usr/sbin/nginx", "-c","etc/nginx/nginx.conf"]
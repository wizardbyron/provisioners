#!/usr/bin/env bash
echo "Install wordpress. Port:80"
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

mkdir -p $HOME/configs/wordpress
cat <<EOF | tee $HOME/configs/wordpress/docker-compose.yaml
version: '3.1'

services:

  wordpress:
    image: wordpress
    restart: always
    ports:
      - 8080:80
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: exampleuser
      WORDPRESS_DB_PASSWORD: examplepass
      WORDPRESS_DB_NAME: exampledb
    volumes:
      - wordpress:/var/www/html

  db:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_DATABASE: exampledb
      MYSQL_USER: exampleuser
      MYSQL_PASSWORD: examplepass
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - db:/var/lib/mysql

volumes:
  wordpress:
  db:
EOF

docker-compose -f $HOME/configs/wordpress/docker-compose.yaml up -d
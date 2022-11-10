sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload
sudo docker-compose up -d
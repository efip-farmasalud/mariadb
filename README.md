docker run -t -d --name mariadb -v data/:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=unasuperpassword -p 3306:3306 --restart always -d mariadb:latest

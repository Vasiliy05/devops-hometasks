docker run -d --name static-site -p 8081:80 hometask-image
docker cp index.html static-site:/var/www/html
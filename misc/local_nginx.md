

docker run --name nginx-local -p 8888:80 \
 -v ~/dir1:/usr/share/nginx/html/dir1:ro \
 -v ~/dir2:/usr/share/nginx/html/dir2:ro \
 nginx

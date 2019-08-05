## Joget + PostgreSQL + Nginx

```
openssl req \
    -newkey rsa:2048 \
    -nodes \
    -keyout z-nginx/my-site.com.key \
    -x509 \
    -days 365 \
    -out z-nginx/my-site.com.crt

wget https://www.joget.org/downloads/enterprise/joget-enterprise-linux-6.0.20.tar.gz -P binary

docker-compose build
open https://my-site.com/jw
```
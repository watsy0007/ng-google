# ng-google

step:

1. edit domain at nginx.conf
1. dns => ip
2. ssh server
3. apt-get install ufw
4. ufw allow ssh
5. ufw allow http
6. ufw allow 443
7. reboot
8. docker pull image
9. git clone https://github.com/letsencrypt/letsencrypt
10. cd letsencrypt/
11. ./letsencrypt-auto certonly --standalone --email email -d domain
12. cp /etc/letsencrypt/live/fuckgfw.today/fullchain.pem /var/local/nginx/certs/gfw.crt
13. cp /etc/letsencrypt/live/fuckgfw.today/privkey.pem /var/local/nginx/certs/gfw.key
14. docker run image

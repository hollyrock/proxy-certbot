cd ~/kicori
docker compose run --rm certbot renew
docker compose exec -T proxy nginx -s reload
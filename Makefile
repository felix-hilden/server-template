build-dev: down up-dev logs

domains = -d example.com -d app.example.com
nginx_incl_path = website/nginx/include

certify:
	mkdir -p "$(nginx_incl_path)"
	curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "$(nginx_incl_path)/options-ssl-nginx.conf"
	curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "$(nginx_incl_path)/ssl-dhparams.pem"
	docker-compose -f docker-compose.yaml -f compose.cert.yaml up -d --remove-orphans
	docker-compose -f docker-compose.yaml -f compose.cert.yaml run --rm certbot \
	  certonly --webroot --webroot-path /var/www/certbot/ $(domains)
	docker-compose -f docker-compose.yaml -f compose.cert.yaml down --remove-orphans

nginx-reload:
	docker-compose exec website nginx -T && nginx -s reload

up-dev:
	docker-compose -f docker-compose.yaml -f compose.dev.yaml up -d --remove-orphans

up-prod:
	docker-compose -f docker-compose.yaml -f compose.prod.yaml up -d --remove-orphans

down:
	docker-compose down --remove-orphans

logs:
	docker-compose logs -t -f

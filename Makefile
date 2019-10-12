install:
	docker-compose exec php-fpm composer create-project laravel/laravel tmp
	rsync -av --remove-source-files tmp/ .
	rm -rf tmp

docker-up: memory
	docker-compose up -d

docker-down:
	docker-compose down

docker-build: memory
	docker-compose up --build -d

artisan:
	docker-compose exec php-fpm ./artisan $(cmd)

composer-install:
	docker-compose exec php-fpm composer install

composer-install-nodev:
	docker-compose exec php-fpm composer install --no-dev

assets-install:
	docker-compose exec node yarn install

assets-rebuild:
	docker-compose exec node npm rebuild node-sass --force

assets-dev:
	docker-compose exec node yarn run dev

assets-watch:
	docker-compose exec node yarn run watch

memory:
	sudo sysctl -w vm.max_map_count=262144

perm:
	sudo chown ${USER}:${USER} app -R
    sudo chown ${USER}:${USER} bootstrap/cache -R
	sudo chown ${USER}:${USER} storage -R
	if [ -d "node_modules" ]; then sudo chown ${USER}:${USER} node_modules -R; fi

# Fix rights of var & public/files folders
.PHONY: init-rw-files
init-rw-files:
	sudo mkdir -p ./var/cache
	sudo chmod -R 777 ./var/cache
	sudo chmod -R 777 ./var/log
	mkdir -p public/files
	sudo chmod -R 777 public/files

.PHONY: install-symfony
install-symfony:
	make check-missing-env
	# Adding env variables for doctrine
	echo "" >> .env
	echo "###> doctrine/doctrine-bundle ###" >> .env
	echo "MYSQL_ADDON_URI=mysql://dev:dev@mysql:3306/$(shell cat .env | grep APPLICATION= | cut -d= -f2)" >> .env
	echo "MYSQL_ADDON_VERSION=8.0" >> .env
	echo "###< doctrine/doctrine-bundle ###" >> .env
	rm -f .env.skeleton
	# Install SF project in a temporary folder
	docker compose exec --user=dev php git config --global user.email "dev@smartbooster.io"
	docker compose exec --user=dev php git config --global user.name "Smartbooster"
	docker compose exec --user=dev php symfony new --dir=project --version=stable --webapp --debug
	# Moving sources to project root and deleting temp folder
	sed -n '16,20p' project/.env >> ./.env # get the random APP_ENV and APP_SECRET generated by the install
	rm -rf project/var project/.env.test project/.gitignore project/docker-compose.yml project/docker-compose.override.yml
	mv project/* ./
	rm -rf project
	make init-rw-files
	# Fix doctrine.yaml + removal of unnecessary bundles from SF webapp
	sed '3,4c\        url: "%env(resolve:MYSQL_ADDON_URI)%"\n        server_version: "%env(resolve:MYSQL_ADDON_VERSION)%"' -i config/packages/doctrine.yaml
	sed '5,8d' -i config/packages/doctrine.yaml
	rm config/packages/messenger.yaml
	docker compose exec --user=dev php composer remove symfony/doctrine-messenger
	echo Install complete!

.PHONY: remove-symfony
remove-symfony:
	sudo rm -rf bin config migrations node_modules public project src templates tests translations vendor ./var/cache ./var/log/php/* composer.json composer.lock phpunit.xml.dist symfony.lock

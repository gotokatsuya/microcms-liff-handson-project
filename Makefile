dev:
	docker-compose up

login:
	gcloud auth login

config:
	gcloud config set project microcms-liff-handson-project

deploy: config
	cd api && gcloud app deploy --quiet app.yaml
	cd web && npm run build && gcloud app deploy --quiet app.yaml
	cd proxy && gcloud app deploy --quiet dispatch.yaml

secret-encrypt:
	LANG=C gpg --symmetric --cipher-algo AES256 ./api/app-secret-env.yaml
	LANG=C gpg --symmetric --cipher-algo AES256 ./web/app-secret-env.yaml

secret-decrypt:
	gpg --quiet --batch --yes --decrypt --passphrase="$(SECRET_PASSPHRASE)" --output ./api/app-secret-env.yaml ./api/app-secret-env.yaml.gpg
	gpg --quiet --batch --yes --decrypt --passphrase="$(SECRET_PASSPHRASE)" --output ./web/app-secret-env.yaml ./web/app-secret-env.yaml.gpg

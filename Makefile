dev: 
	docker-compose up

login:
	gcloud auth login

config:
	gcloud config set project microcms-liff-handson-project

deploy: config
	cd proxy && gcloud app deploy dispatch.yaml
	cd api && gcloud app deploy app.yaml
	cd web && npm run build && gcloud app deploy app.yaml

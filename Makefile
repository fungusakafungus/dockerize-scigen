setup:
	mkdir -p scigen/scigen/
	git clone https://github.com/bnurgenc/scigen.git scigen/scigen/
run:
	docker build -t scigen .
	docker run --rm -ti -v ${PWD}/scigen:/scigen/scigen -p 8080:8080 scigen
push:
	docker tag scigen eu.gcr.io/python-search-158121/scigen
	gcloud docker -- push eu.gcr.io/python-search-158121/scigen
deploy: push
	kubectl apply -f deployment.yaml
	kubectl delete pod -l app=scigen

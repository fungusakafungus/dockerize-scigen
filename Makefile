run:
	docker build -t scigen .
	docker run --rm -ti -v ${PWD}/scigen:/scigen/scigen -p 8080:8080 scigen
publish:
	docker tag scigen eu.gcr.io/python-search-158121/scigen
	gcloud docker -- push eu.gcr.io/python-search-158121/scigen

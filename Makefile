help:
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*"

docker-build:
	docker build --tag=docker-test .

docker-run: docker-build
	docker run --rm -it -v "$(pwd):/app:consistent" docker-test:latest

app-run: docker-build
	docker run --rm -it -v "$(shell pwd):/app:consistent" docker-test:latest \
	mvn -Dmaven.repo.local="/app/mvn-repository" package && \
	java -jar target/HelloDocker-1.0.jar
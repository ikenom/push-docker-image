docker build -t push-docker-image . --file Dockerfile.push-docker-image
docker run -it -v /var/run/docker.sock:/var/run/docker.sock push-docker-image
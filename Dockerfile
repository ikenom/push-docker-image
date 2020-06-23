FROM docker
RUN apk add --no-cache bash

RUN mkdir /app
WORKDIR /app

COPY ./scripts/entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

WORKDIR /data/push-docker-image

ENTRYPOINT ["bash", "/app/entrypoint.sh"]

# Docker image for the ecr plugin
#
#     docker build --rm=true -t plugins/ecr .

FROM plugins/docker:latest

RUN \
	mkdir -p /aws && \
	apk -Uuv add groff less python py-pip && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

ADD bin/wrap-drone-docker.sh /bin/wrap-drone-docker.sh

ADD bin/docker-credential-ecr-login /usr/bin/docker-credential-ecr-login
RUN \
	mkdir -p $HOME/.docker && \
	echo '{"credsStore": "ecr-login"}' > $HOME/.docker/config.json

ENTRYPOINT /bin/wrap-drone-docker.sh

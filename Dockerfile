FROM vfac/envdevphpbase:7.0-fpm-alpine
LABEL maintainer="Vincent Faliès <vincent@vfac.fr>"

USER root

# NodeJS, NPM, Yarn
RUN apk --update add ca-certificates && \
     echo "@edge-community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
     echo "@edge-main http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
     apk add --no-cache $PHPIZE_DEPS && \
     apk add -U \
        bash@edge-main \
        nodejs@edge-main \
        nodejs-npm@edge-main \
        yarn@edge-main \
     && rm -rf /var/cache/apk/*

# NPM last version
RUN npm i npm@latest -g

# Grunt
RUN npm install -g grunt-cli

# Gulp
RUN npm install -g gulp-cli \
    && npm install gulp -D

USER vfac:vfac
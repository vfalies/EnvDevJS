FROM debian:buster-slim
LABEL maintainer="Vincent Faliès <vincent@vfac.fr>"

RUN apt-get update && apt-get install -y \
    gnupg2 \
    curl

# Node JS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs build-essential \
    && rm -rf /var/lib/apt/lists/*

# NPM last version
RUN npm i npm@latest -g

# Grunt
RUN npm install -g grunt-cli

# Gulp
RUN npm install -g gulp-cli \
    && npm install gulp -D

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install --no-install-recommends yarn

# Typescript
RUN npm install -g typescript

# User creation
RUN useradd -U -m -r -o -u 1003 vfac

# Install fixuid
RUN USER=vfac && \
    GROUP=vfac && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml
ENTRYPOINT ["fixuid", "-q"]

USER vfac:vfac

CMD ["tail", "-f", "/dev/null"]
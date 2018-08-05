FROM vfac/envdevphpbase:7.0-fpm
LABEL maintainer="Vincent Faliès <vincent@vfac.fr>"

USER root

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
    && apt-get update && apt-get install --no-install-recommends yarn \
    && rm -rf /var/lib/apt/lists/*

# Typescript
RUN npm install -g typescript

USER vfac:vfac
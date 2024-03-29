# https://qiita.com/baban/items/99877f9b3065c4cf3d50 をベースにした
FROM node:16-alpine3.15 as node

FROM ruby:3.0-alpine3.15 as builder

# webpacker用にnode環境を作成
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /opt/yarn-v1.22.18 /opt/yarn
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
    ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm && \
    ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn

RUN apk --update --no-cache add \
    shadow \
    sudo \
    busybox-suid \
    tzdata \
    postgresql-dev \
    build-base \
    libc6-compat \
    alpine-sdk

WORKDIR /rails
COPY Gemfile Gemfile.lock ./
RUN gem install bundler --version 2.2.17 \
    && bundle lock --add-platform x86_64-linux \
    && bundle config set --local deployment 'true' \
    && bundle config set --local without 'development test' \
    && bundle config set force_ruby_platform true \
    && bundle install --retry 5 \
    && find vendor/bundle/ruby -path '*/gems/*/ext/*/Makefile' -exec dirname {} \; | xargs -n1 -P$(nproc) -I{} make -C {} clean

COPY package.json yarn.lock ./
RUN yarn install && yarn cache clean

COPY Rakefile babel.config.js postcss.config.js ./
COPY app/javascript app/javascript
COPY app/assets app/assets
COPY vendor/assets vendor/assets
COPY bin bin
COPY config config
ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE
ENV RAILS_ENV=production
RUN bundle exec rails assets:precompile

# 最終的に生成されるイメージ
FROM ruby:3.0-alpine3.15
RUN apk --update --no-cache add \
    shadow \
    sudo \
    busybox-suid \
    execline \
    postgresql-dev \
    tzdata \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && apk del --purge tzdata

WORKDIR /rails
COPY --from=builder /rails/vendor/bundle/ /rails/vendor/bundle/
COPY --from=builder /rails/public/assets/ /rails/public/assets/
COPY --from=builder /rails/public/packs/ /rails/public/packs/
COPY . /rails
RUN gem install bundler --version 2.2.17 \
    && bundle lock --add-platform x86_64-linux \
    && bundle config set --local deployment 'true' \
    && bundle config set --local without 'development test' \
    && bundle config set force_ruby_platform true \
    && bundle install --retry 5 \

# syntax=docker/dockerfile:1.4
FROM directus/directus:10.6.2
USER root
RUN corepack enable \
    && corepack prepare pnpm@8.7.6 --activate \
    && chown node:node /directus
ADD https://github.com/Stash-Ventures/hybrid-cms-directus/blob/master/extensions.tar.gz /directus
RUN tar -xzf extensions.tar.gz \
    && rm extensions.tar.gz
EXPOSE 8055
USER node
CMD : \
    && node /directus/cli.js bootstrap \
    && node /directus/cli.js start;
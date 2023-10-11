# syntax=docker/dockerfile:1.4
FROM directus/directus:10.6.3
USER root
ADD ./extensions.tar.gz /directus
# RUN tar -xvzf /directus/extensions.tar.gz \
#     && rm /directus/extensions.tar.gz
RUN corepack enable \
    && corepack prepare pnpm@8.7.6 --activate \
    && chown node:node /directus
EXPOSE 8055
USER node
CMD : \
    && node /directus/cli.js bootstrap \
    && node /directus/cli.js start;
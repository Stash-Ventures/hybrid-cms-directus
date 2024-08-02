# syntax=docker/dockerfile:1.4
FROM directus/directus:10.7.2
USER root
ADD ./extensions.tar.gz /directus
# RUN tar -xvzf /directus/extensions.tar.gz \
#     && rm /directus/extensions.tar.gz
RUN corepack enable \
    && corepack prepare pnpm@8.7.6 --activate \
    && chown node:node /directus

EXPOSE 8055
ENV NODE_OPTIONS=--max_old_space_size=8192
USER node

RUN pnpm install cloudinary @supabase/supabase-js cors express-fileupload form-data form-data-encoder formdata-node directus-extension-key-value-interface

CMD : \
    && node /directus/cli.js bootstrap \
    && node /directus/cli.js start;
FROM n8nio/n8n:latest

USER root

RUN apk add --update --no-cache \
    python3 \
    py3-pip \
    build-base \
    cairo-dev \
    jpeg-dev \
    pango-dev \
    musl-dev \
    && ln -sf /usr/bin/python3 /usr/bin/python

USER node

WORKDIR /home/node

COPY package*.json ./

RUN npm ci --omit=dev --cache /tmp/empty-cache

EXPOSE 5678

RUN mkdir -p /home/node/.n8n

CMD ["n8n", "start"]
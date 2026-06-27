ARG NODE_VERSION=24.13.0-slim

FROM node:${NODE_VERSION} AS dependencies

WORKDIR /app

# install only what we need
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# copy app
COPY server.js .

ENV NODE_TLS_REJECT_UNAUTHORIZED=0
ENV HOST=0.0.0.0
ENV PORT=80

EXPOSE 80

CMD ["node", "server.js"]
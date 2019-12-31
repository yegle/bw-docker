# NOTE: the version here is to match distroless's NodeJS version.
FROM node:10.16.3-stretch as build_env

WORKDIR /app
ADD ./package-lock.json /app
ADD ./package.json /app
RUN npm ci

FROM gcr.io/distroless/nodejs

COPY --from=build_env /app /app
WORKDIR /app
ENTRYPOINT ["/nodejs/bin/node", "/app/node_modules/.bin/bw"]

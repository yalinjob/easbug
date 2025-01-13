# Stage 1: Build Node.js dependencies
FROM node:12-alpine AS builder
ENV WORKDIR /usr/src/app/
WORKDIR $WORKDIR
COPY package*.json $WORKDIR
RUN npm install --production && ls -la /usr/src/app

# Stage 2: Python runtime
FROM python:rc-alpine3.13
ENV USER node
ENV WORKDIR /home/$USER/app
WORKDIR $WORKDIR
COPY --from=builder /usr/src/app/node_modules ./node_modules
RUN chown $USER:$USER $WORKDIR
COPY --chown=node . $WORKDIR

EXPOSE 22


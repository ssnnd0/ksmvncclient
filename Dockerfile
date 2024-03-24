# syntax=docker/dockerfile:1

FROM node:12-buster

ARG KASMWEB_RELEASE="54b9bac920267e902af3c9dfca4c0f64cff92f41"

WORKDIR /app
ADD . .

RUN \
  echo "**** build clientside ****" && \
  export QT_QPA_PLATFORM=offscreen && \
  export QT_QPA_FONTDIR=/usr/share/fonts && \
  npm install && \
  npm run-script build

RUN \
  echo "**** organize output ****" && \
  mkdir /build-out && \
  rm -rf node_modules/ && \
  cp -R /app/* /build-out/ && \
  cd /build-out && \
  rm *.md && \
  rm AUTHORS && \
  cp index.html vnc.html && \
  mkdir Downloads

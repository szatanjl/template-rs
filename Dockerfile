ARG BASEIMG=alpine:latest
ARG BUILDIMG=$BASEIMG


FROM $BUILDIMG AS build
WORKDIR /app
RUN apk --no-cache add make
COPY . .
RUN make

ARG BASEIMG=alpine:latest
ARG BUILDIMG=$BASEIMG
ARG RUNIMG=$BASEIMG


FROM $BUILDIMG AS build
WORKDIR /app/src
RUN apk --no-cache add make
COPY . .
RUN { [ -r version.mk ] && sed '/^$/q; s/^/\t/' version.mk; } || \
    printf '\tNO VERSION\n'
RUN make
RUN make DESTDIR=/app/dst localstatedir=/var install


FROM $RUNIMG AS run
WORKDIR /
COPY --from=build /app/dst .
ENTRYPOINT ["hello"]

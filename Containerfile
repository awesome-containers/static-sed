# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15

FROM ghcr.io/awesome-containers/alpine-build-essential:3.17 AS build

# https://ftp.gnu.org/gnu/sed/
ARG SED_VERSION=4.9

WORKDIR /src/sed
RUN set -xeu; \
    curl -#Lo sed.tar.gz \
        "https://ftp.gnu.org/gnu/sed/sed-$SED_VERSION.tar.xz"; \
    tar -xvf sed.tar.gz --strip-components=1; \
    rm -f sed.tar.gz

ARG CFLAGS='-w -g -Os -static'
RUN set -xeu; \
    ./configure; \
    make -j"$(nproc)"; \
    chmod -cR 755 sed/sed; \
    chown -cR 0:0 sed/sed; \
    ! ldd sed/sed && :; \
    ./sed/sed --version

# static Curl image
FROM ghcr.io/awesome-containers/static-bash:$STATIC_BASH_VERSION
COPY --from=build /src/sed/sed/sed /bin/sed

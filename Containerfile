# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15
ARG STATIC_BASH_IMAGE=ghcr.io/awesome-containers/static-bash

# https://github.com/awesome-containers/alpine-build-essential
ARG BUILD_ESSENTIAL_VERSION=3.17
ARG BUILD_ESSENTIAL_IMAGE=ghcr.io/awesome-containers/alpine-build-essential


FROM $STATIC_BASH_IMAGE:$STATIC_BASH_VERSION AS static-bash
FROM $BUILD_ESSENTIAL_IMAGE:$BUILD_ESSENTIAL_VERSION AS build

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
    strip -s -R .comment --strip-unneeded sed/sed; \
    chmod -cR 755 sed/sed; \
    chown -cR 0:0 sed/sed; \
    ! ldd sed/sed && :; \
    ./sed/sed --version

# static sed image
FROM static-bash
COPY --from=build /src/sed/sed/sed /bin/sed
